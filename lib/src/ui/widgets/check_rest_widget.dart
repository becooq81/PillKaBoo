import '../../core/pillkaboo_util.dart';
import '../../app/global_audio_player.dart';
import 'views/detector_view.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';




class CheckRestWidget extends StatefulWidget {
  final StreamController<bool> controller;
  const CheckRestWidget({
    super.key,
    this.width,
    this.height,
    required this.controller,
  });
  final double? width;
  final double? height;
  @override
  _CheckRestWidgetState createState() => _CheckRestWidgetState();
}

class _CheckRestWidgetState extends State<CheckRestWidget> {
  bool _canProcess = true; // 이미지 처리 가능 여부
  bool _isBusy = false; // 이미지 처리 중 여부
  int? _recognizedAmount; // 인식된 양
  bool _isAmountRecognized = false; // 양 인식 여부
  var _cameraLensDirection = CameraLensDirection.back; // 카메라 렌즈 방향

  @override
  void initState() {
    super.initState();
    listenForPermissions();
    GlobalAudioPlayer().playRepeat();
  }

  // 카메라 권한 확인
  void listenForPermissions() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status.isPermanentlyDenied) {
      openAppSettings();
    } else if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  @override
  void dispose() async {
    _canProcess = false;
    GlobalAudioPlayer().pause();
    super.dispose();
  }

  /**
   * TTS 대신 다음 코드 사용
   * SemanticsService.announce(
      "카메라에 약을 천천히 돌려가며 여러 면을 비춰주세요.",
      ui.TextDirection.ltr,);

      참고: custom_gesture_slider.dart
   */

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isAmountRecognized) {
        widget.controller.add(true);
      }
    });

    return _isAmountRecognized
        ? const CircularProgressIndicator()
        : DetectorView(
      title: 'Scanner',
      customPaint: null,
      text: null,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  // 이미지 처리
  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      // 현재 양 값 설정 등
      // _recognizedAmount = 100;
    });

    _recognizedAmount = 100;
    print(_recognizedAmount);

    // 이미지 처리 후 분량 확인됐는지 여부 업데이트
    _isAmountRecognized = true;


    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}