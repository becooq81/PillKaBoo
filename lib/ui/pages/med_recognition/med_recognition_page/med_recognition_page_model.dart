import '../../../../core/pillkaboo_model.dart';
import 'med_recognition_page_widget.dart' show MedRecognitionPageWidget;
import 'package:flutter/material.dart';

class MedRecognitionPageModel extends PillKaBooModel<MedRecognitionPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}