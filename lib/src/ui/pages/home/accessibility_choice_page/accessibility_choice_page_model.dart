import '../../../../core/pillkaboo_util.dart';
import 'accessibility_choice_page_widget.dart' show AccessibilityChoicePageWidget;
import 'package:flutter/material.dart';

class AccessibilityChoicePageModel extends PillKaBooModel<AccessibilityChoicePageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}