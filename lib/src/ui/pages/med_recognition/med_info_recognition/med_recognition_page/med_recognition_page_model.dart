import '../../../../../core/pillkaboo_model.dart';
import 'med_recognition_page_widget.dart' show MedRecognitionPageWidget;
import 'package:flutter/material.dart';

class MedRecognitionPageModel extends PillKaBooModel<MedRecognitionPageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}