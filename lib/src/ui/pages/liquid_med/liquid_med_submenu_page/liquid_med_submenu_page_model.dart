import '../../../../core/pillkaboo_util.dart';
import 'liquid_med_submenu_page_widget.dart' show LiquidMedSubmenuPageWidget;
import 'package:flutter/material.dart';

class LiquidMedSubmenuPageModel extends PillKaBooModel<LiquidMedSubmenuPageWidget> {

  final unfocusNode = FocusNode();


  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}