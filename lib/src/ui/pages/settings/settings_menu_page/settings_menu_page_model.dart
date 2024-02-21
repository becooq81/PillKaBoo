import '../../../../core/pillkaboo_model.dart';
import 'settings_menu_page_widget.dart' show SettingsMenuPageWidget;
import 'package:flutter/material.dart';

class SettingsMenuPageModel extends PillKaBooModel<SettingsMenuPageWidget> {

  final unfocusNode = FocusNode();


  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}