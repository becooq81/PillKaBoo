import '../../../../../core/pillkaboo_util.dart';
import 'prescribed_med_recognition_page_widget.dart' show PrescribedMedRecognitionPageWidget;
import 'package:flutter/material.dart';

class PrescribedMedRecognitionPageModel extends PillKaBooModel<PrescribedMedRecognitionPageWidget> {

  final unfocusNode = FocusNode();


  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}