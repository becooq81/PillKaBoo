import '../../../../core/pillkaboo_model.dart';
import 'settings_menu_page_widget.dart' show SettingsMenuPageWidget;
import 'package:flutter/material.dart';

class SettingsMenuPageModel extends PillKaBooModel<SettingsMenuPageWidget> {
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