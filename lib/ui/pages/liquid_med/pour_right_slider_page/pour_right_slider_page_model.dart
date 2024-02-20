import '../../../../core/pillkaboo_util.dart';
import 'pour_right_slider_page_widget.dart' show PourRightSliderPageWidget;
import 'package:flutter/material.dart';

class PourRightSliderPageModel extends PillKaBooModel<PourRightSliderPageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
