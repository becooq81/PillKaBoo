import '../../../../core/pillkaboo_util.dart';
import 'med_info_page_widget.dart' show MedInfoPageWidget;
import 'package:flutter/material.dart';

class MedInfoPageModel extends PillKaBooModel<MedInfoPageWidget> {
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