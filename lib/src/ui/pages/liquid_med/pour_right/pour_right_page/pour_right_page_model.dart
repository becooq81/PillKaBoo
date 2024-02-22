import '../../../../../core/pillkaboo_util.dart';
import 'pour_right_page_widget.dart' show PourRightPageWidget;
import 'package:flutter/material.dart';

class PourRightPageModel extends PillKaBooModel<PourRightPageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}