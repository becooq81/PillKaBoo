import '../../../../../core/pillkaboo_util.dart';
import 'pour_right_result_page_widget.dart' show PourRightResultPageWidget;
import 'package:flutter/material.dart';

class PourRightResultPageModel extends PillKaBooModel<PourRightResultPageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}