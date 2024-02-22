import '../../../core/pillkaboo_util.dart';
import '../../../app/global_audio_player.dart';
import '../views/detector_view.dart';
import '../../../data/local/database/barcode_db_helper.dart';
import '../../../data/local/database/processed_file_db_helper.dart';
import '../../../data/local/database/ingredients_db_helper.dart';
import '../../../data/local/database/children_db_helper.dart';
import '../../../utils/date_parser.dart';
import '../views/barcode_detector_painter.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'dart:async';
import 'package:flutter/semantics.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';


class MedRecognizerWidget extends StatefulWidget {
  final StreamController<bool> controller;
  const MedRecognizerWidget({
    super.key,
    this.width,
    this.height,
    required this.controller,
  });
  final double? width;
  final double? height;
  @override
  _MedRecognizerWidgetState createState() => _MedRecognizerWidgetState();
}

class _MedRecognizerWidgetState extends State<MedRecognizerWidget> {

  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.korean); // 한국어 Text Recognition 언어 설정
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = true; // 이미지 처리 가능 여부
  bool _isBusy = false; // 이미지 처리 중 여부
  CustomPaint? _customPaint; // 이미지에 그려질 CustomPaint

  String? _recognizedBarcode; // 인식된 바코드

  var _cameraLensDirection = CameraLensDirection.back; // 카메라 렌즈 방향

  bool _isDateRecognized = false; // 날짜 인식 여부
  bool _isBarcodeRecognized = false; // 바코드 인식 여부

  String _medTitle = "";
  String _exprDate = "";
  Map<String, dynamic> _medicineInfo = {}; // 약 정보

  @override
  void initState() {
    super.initState();
    listenForPermissions();
    _isDateRecognized = false;
    _isBarcodeRecognized = false;
    GlobalAudioPlayer().playRepeat();
    setState(() {
      PKBAppState().infoMedName = "";
      PKBAppState().infoExprDate = "";
      PKBAppState().infoUsage = "";
      PKBAppState().infoHowToTake = "";
      PKBAppState().infoWarning = "";
      PKBAppState().infoCombo = "";
      PKBAppState().infoSideEffect = "";
      PKBAppState().infoIngredient = "";
      PKBAppState().infoChild = "";
      PKBAppState().foundAllergies = "";
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
    _barcodeScanner.close();
    GlobalAudioPlayer().pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isBarcodeRecognized && _isDateRecognized && PKBAppState().infoMedName != "" && PKBAppState().infoExprDate != "") {
        _isBarcodeRecognized = false;
        _isDateRecognized = false;
        widget.controller.add(true);
      }
    });

    return _isBarcodeRecognized && _isDateRecognized
        ? const LinearProgressIndicator()
        : DetectorView(
          title: 'Barcode Scanner',
          customPaint: _customPaint,
          text: _recognizedBarcode,
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
      _recognizedBarcode = '';
    });

    final text = await _textRecognizer.processImage(inputImage);
    final barcodes = await _barcodeScanner.processImage(inputImage);

    if (!_isDateRecognized) {
      List<String> splitText = text.text.split(RegExp(r'\s+'));
      for (String word in splitText) {
        if (DateParser.isDate(word)) {
          final date = DateParser.parseDate(word);
          if (date != null) {
            if (mounted) {
              setState(() {
                _isDateRecognized = true;
              });
            }
            triggerVibrationIfNecessary();
            if (_exprDate == "") {
              _exprDate =
                  "${date.year}년 ${date.month}월 ${date.day}일";
            }
            PKBAppState().infoExprDate = _exprDate;
            _exprDate = "";
            break;
          }
        }
      }
    }
    if (!_isBarcodeRecognized) {
      for (final barcode in barcodes) {
        if (barcode.rawValue != null) {
          final recognizedBarcode = barcode.rawValue!;
          final matches = await BarcodeDBHelper.searchByBarcode(recognizedBarcode);
          if (matches.isNotEmpty) {
            if (mounted) {
              setState(() {
                _isBarcodeRecognized = true;
              });
            }
            triggerVibrationIfNecessary();
            _medicineInfo = matches[0];
            final itemSeq = _medicineInfo['품목기준코드'];
            final medInfo = await ProcessedFileDBHelper.searchByItemSeq(itemSeq);
            final ingreInfo = await IngredientsDBHelper.searchIngredientsBySeqNum(itemSeq);
            final childInfo = await ChildrenDBHelper.searchChildByItemCode(itemSeq);
            if (medInfo.isNotEmpty) {
              final med = medInfo.first;
              _isBarcodeRecognized = true;
              if (_medTitle == ""){
                _medTitle = med['itemName'];
                PKBAppState().infoMedName = _medTitle;
                _medTitle = "";
                PKBAppState().infoUsage = med['efcyQesitm'];
                PKBAppState().infoHowToTake = med['useMethodQesitm'];
                PKBAppState().infoWarning =
                    med['atpnWarnQesitm'] + med['atpnQesitm'];
                PKBAppState().infoCombo = med['intrcQesitm'];
                PKBAppState().infoSideEffect = med['seQesitm'];
              }
            } else {
              SemanticsService.announce("약 정보를 찾을 수 없습니다.", ui.TextDirection.ltr);
            }
            if (ingreInfo.isNotEmpty) {
              final ingre = ingreInfo.first;
              PKBAppState().infoIngredient = ingre['주성분'];
              for (String allergy in PKBAppState().userAllergies) {
                if (ingre['주성분'].contains(allergy)) {
                  if (PKBAppState().foundAllergies.contains(allergy)) {
                    continue;
                  }
                  PKBAppState().foundAllergies += "$allergy ";
                }
              }
            }
            if (childInfo.isNotEmpty) {
              final child = childInfo.first;
              PKBAppState().infoChild = child['combined'];
            }
          }
        }
      }

    }
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = BarcodeDetectorPainter(
        barcodes,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Barcodes found: ${barcodes.length}\n\n';
      for (final barcode in barcodes) {
        text += 'Barcode: ${barcode.rawValue}\n\n';
      }
      _recognizedBarcode = text;
      _customPaint = null;
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

}