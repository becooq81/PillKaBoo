import '../../../../../core/pillkaboo_model.dart';
import 'allergy_list_page_widget.dart' show AllergyListPageWidget;
import 'package:flutter/material.dart';

class AllergyListPageModel extends PillKaBooModel<AllergyListPageWidget> {

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}