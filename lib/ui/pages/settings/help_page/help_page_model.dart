import '../../../../core/pillkaboo_model.dart';
import 'help_page_widget.dart' show HelpPageWidget;
import 'package:flutter/material.dart';

class HelpPageModel extends PillKaBooModel<HelpPageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}