import '../../../../core/pillkaboo_util.dart';
import 'liquid_med_submenu_page_widget.dart' show LiquidMedSubMenuPageWidget;
import 'package:flutter/material.dart';

class LiquidMedSubMenuPageModel extends PillKaBooModel<LiquidMedSubMenuPageWidget> {

  final unfocusNode = FocusNode();


  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}