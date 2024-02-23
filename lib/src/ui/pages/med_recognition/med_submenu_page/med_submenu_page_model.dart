import '../../../../core/pillkaboo_util.dart';
import 'med_submenu_page_widget.dart' show MedSubmenuPageWidget;
import 'package:flutter/material.dart';

class MedSubmenuPageModel extends PillKaBooModel<MedSubmenuPageWidget> {

  final unfocusNode = FocusNode();


  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}