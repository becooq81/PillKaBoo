import '../../../../core/pillkaboo_util.dart';
import 'check_rest_page_widget.dart' show CheckRestPageWidget;
import 'package:flutter/material.dart';

class CheckRestPageModel extends PillKaBooModel<CheckRestPageWidget> {
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
