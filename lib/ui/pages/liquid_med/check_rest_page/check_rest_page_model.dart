import '../../../../core/pillkaboo_util.dart';
import 'check_rest_page_widget.dart' show CheckRestPageWidget;
import 'package:flutter/material.dart';

class CheckRestPageModel extends PillKaBooModel<CheckRestPageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
