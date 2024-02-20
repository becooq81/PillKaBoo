import '../../../../core/pillkaboo_util.dart';
import 'pour_right_slider_page_widget.dart' show PourRightSliderPageWidget;
import 'package:flutter/material.dart';

class PourRightSliderPageModel extends PillKaBooModel<PourRightSliderPageWidget> {
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
