import '../../../../../../core/pillkaboo_model.dart';
import 'allergy_add_page_widget.dart' show AllergyAddPageWidget;
import 'package:flutter/material.dart';

class AllergyAddPageModel extends PillKaBooModel<AllergyAddPageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}