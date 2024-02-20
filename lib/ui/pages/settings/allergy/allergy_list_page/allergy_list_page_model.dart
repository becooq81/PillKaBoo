import '../../../../../../core/pillkaboo_model.dart';
import 'allergy_list_page_widget.dart' show AllergyListPageWidget;
import 'package:flutter/material.dart';

class AllergyListPageModel extends PillKaBooModel<AllergyListPageWidget> {
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