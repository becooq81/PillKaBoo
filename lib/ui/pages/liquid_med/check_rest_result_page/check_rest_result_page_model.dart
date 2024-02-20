import '../../../../core/pillkaboo_util.dart';
import 'check_rest_result_page_widget.dart' show CheckRestResultPageWidget;
import 'package:flutter/material.dart';

class CheckRestResultPageModel extends PillKaBooModel<CheckRestResultPageWidget> {
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
