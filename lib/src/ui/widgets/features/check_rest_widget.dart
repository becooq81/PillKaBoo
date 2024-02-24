import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../../../app/global_audio_player.dart';
import '../../../core/pillkaboo_util.dart';
import 'dart:core';
//import '../../../utils/liquid_volume_estimator.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class CheckRestWidget extends StatefulWidget {
  final StreamController<bool> controller;

  const CheckRestWidget({
    Key? key,
    this.width,
    this.height,
    required this.controller,
  }) : super(key: key);
  final double? width;
  final double? height;
  @override
  State<CheckRestWidget> createState() => _CameraViewState();
}

class _CameraViewState extends State<CheckRestWidget> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  Timer? _pictureTimer;
  int _currentCC = 0;
  bool _isRestRecognized = false;

  //LiquidVolumeEstimator liquidVolumeEstimator = LiquidVolumeEstimator();

  @override
  void initState() {
    super.initState();
    GlobalAudioPlayer().playRepeat();
    _initialize();
  }


  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == CameraLensDirection.back) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _pictureTimer?.cancel();
    GlobalAudioPlayer().pause();
    //liquidVolumeEstimator.stop();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isRestRecognized) {
        _isRestRecognized = false;
        GlobalAudioPlayer().pause();
        widget.controller.add(true);
        print("WIDGET CONTRLLER WORKING");
      }
    });
    */
    
    return Scaffold(body: _liveFeedBody());
  }

  Widget _liveFeedBody() {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: CameraPreview(
                    _controller!,
                    child: null,
                  ),
          ),
        ],
      ),
    );
  }

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _pictureTimer =
          Timer.periodic(const Duration(milliseconds: 500), (timer) {
        _takePicture();
      });
      setState(() {});
    });
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) {
      // Check if the controller is initialized
      debugPrint("Controller is not initialized");
      return;
    }
    if (_controller!.value.isTakingPicture) {
      // If a capture is already pending, do not take another
      return;
    }
    try {
      final picture = await _controller!.takePicture();
      await _analyzePicture(picture);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _analyzePicture(XFile picture) async {
    final path = join(
      (await getApplicationDocumentsDirectory()).path,
      "${DateTime.now()}.jpg",
    );
    await picture.saveTo(path);

    final req = http.MultipartRequest(
        "POST", Uri.parse("http://pill.m3sigma.net:3000/"));
    final image = await http.MultipartFile.fromPath("image", path);
    req.files.add(image);
    final res = await http.Response.fromStream(await req.send());
    final resData = jsonDecode(res.body) as Map<String, dynamic>;

    if (resData["cc"] == null) {
      debugPrint("null");
    } else {
      _currentCC = resData["cc"];
      PKBAppState().restAmount = _currentCC;
      debugPrint("APP STATE: ${PKBAppState().restAmount}");
      _isRestRecognized = true;
      widget.controller.add(true);
      dispose();
    }
    debugPrint("ESTIMATED CC: $_currentCC");
  }

  List<List<int>> reshape(List<int> flatList, int height, int width) {
    List<List<int>> reshaped =
        List.generate(height, (_) => List.filled(width, 0));
    for (int i = 0; i < height; i++) {
      for (int j = 0; j < width; j++) {
        int index = i * width + j;
        if (index < flatList.length) {
          reshaped[i][j] = flatList[index];
        }
      }
    }
    return reshaped;
  }


  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };
  
}