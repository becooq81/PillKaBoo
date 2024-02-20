import '../../../../core/pillkaboo_util.dart';
import 'pick_color_page_widget.dart' show PickColorPageWidget;
import 'package:flutter/material.dart';

class PickColorPageModel extends PillKaBooModel<PickColorPageWidget> {
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