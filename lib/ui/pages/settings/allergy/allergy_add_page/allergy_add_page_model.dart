import '../../../../../../core/pillkaboo_model.dart';
import 'allergy_add_page_widget.dart' show AllergyAddPageWidget;
import 'package:flutter/material.dart';

class AllergyAddPageModel extends PillKaBooModel<AllergyAddPageWidget> {
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