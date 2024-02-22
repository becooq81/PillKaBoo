import '../../../../core/pillkaboo_util.dart';
import 'med_submenu_page_widget.dart' show MedSubMenuPageWidget;
import 'package:flutter/material.dart';

class MedSubMenuPageModel extends PillKaBooModel<MedSubMenuPageWidget> {

  final unfocusNode = FocusNode();


  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}