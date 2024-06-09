import '../../../core/pillkaboo_util.dart';
import '../../../app/global_audio_player.dart';
import '../views/detector_view.dart';
import '../views/text_detector_painter.dart';
import '../../../utils/date_parser.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class PrescribedMedRecognizerWidget extends StatefulWidget {
  final StreamController<bool> controller;
  const PrescribedMedRecognizerWidget({
    super.key,
    this.width,
    this.height,
    required this.controller,
  });
  final double? width;
  final double? height;

  @override
  State<PrescribedMedRecognizerWidget> createState() => _PrescribedMedRecognizerWidgetState();
}

class _PrescribedMedRecognizerWidgetState extends State<PrescribedMedRecognizerWidget> {

  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.korean); // 한국어 Text Recognition 언어 설정
  bool _canProcess = true; // 이미지 처리 가능 여부
  bool _isBusy = false; // 이미지 처리 중 여부
  CustomPaint? _customPaint; // 이미지에 그려질 CustomPaint
  var _cameraLensDirection = CameraLensDirection.back; // 카메라 렌즈 방향
  String? _text;
  bool _isTextRecognized = false; // 시간 인식 여부
  bool _isDateRecognized = false;

  @override
  void initState() {
    super.initState();
    listenForPermissions();
    _isTextRecognized = false;
    GlobalAudioPlayer().playRepeat();
    setState(() {
      PKBAppState().slotOfDay = "";
    });
  }

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
    _textRecognizer.close();
    GlobalAudioPlayer().pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isTextRecognized && _isDateRecognized && PKBAppState().slotOfDay != "") {
        triggerVibrationIfNecessary();
        _isTextRecognized = false;
        _isDateRecognized = false;
        widget.controller.add(true);
      }
    });

    // Continue to build your widget as normal.
    return _isTextRecognized && _isDateRecognized
        ? const LinearProgressIndicator()
        : DetectorView(
          title: 'Barcode Scanner',
          customPaint: _customPaint,
          text: _text,
          onImage: _processImage,
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
        );
  }

  // 진동
  void triggerVibrationIfNecessary() {
    Vibration.vibrate();
  }

  /**
   * text recognition & barcode detection methods
   */
  // 이미지 처리
  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });

    final recognizedText = await _textRecognizer.processImage(inputImage);

    if (partialRatio("아침", recognizedText.text) == 100) {
      _isTextRecognized = true;
      PKBAppState().slotOfDay = "아침";
    } else if (partialRatio("점심", recognizedText.text) == 100) {
      _isTextRecognized = true;
      PKBAppState().slotOfDay = "점심";
    } else if (partialRatio("저녁", recognizedText.text) == 100) {
      _isTextRecognized = true;
      PKBAppState().slotOfDay = "저녁";
    } else {
      PKBAppState().slotOfDay = "";
    }

    List<String> splitText = recognizedText.text.split(RegExp(r'\s+'));
      for (String word in splitText) {
        if (DateParser.isDate(word)) {
          final date = DateParser.parseDateIfBeforeToday(word);
          if (date != null) {
            if (mounted) {
              _isDateRecognized = true;
              PKBAppState().infoPrescribedDate = "${date.year}년 ${date.month}월 ${date.day}일";
            }
          }
        }
      }

    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(
        recognizedText,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}