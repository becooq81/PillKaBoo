import '../../../../core/pillkaboo_util.dart';
import 'pick_color_page_widget.dart' show PickColorPageWidget;
import 'package:flutter/material.dart';

class PickColorPageModel extends PillKaBooModel<PickColorPageWidget> {
  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}