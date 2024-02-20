import '../../../../core/pillkaboo_util.dart';
import 'liquid_med_submenu_page_widget.dart' show LiquidMedSubMenuPageWidget;
import 'package:flutter/material.dart';

class LiquidMedSubMenuPageModel extends PillKaBooModel<LiquidMedSubMenuPageWidget> {
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