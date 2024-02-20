import '../../../../core/pillkaboo_util.dart';
import 'pour_right_page_widget.dart' show PourRightPageWidget;
import 'package:flutter/material.dart';

class PourRightPageModel extends PillKaBooModel<PourRightPageWidget> {
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