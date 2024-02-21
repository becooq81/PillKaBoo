import '../../../../core/pillkaboo_util.dart';
import 'check_rest_result_page_widget.dart' show CheckRestResultPageWidget;
import 'package:flutter/material.dart';

class CheckRestResultPageModel extends PillKaBooModel<CheckRestResultPageWidget> {

  final unfocusNode = FocusNode();


  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
