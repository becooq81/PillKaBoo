import '../../../../core/pillkaboo_util.dart';
import '../../../widgets/index.dart' as widgets;

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'check_rest_page_model.dart';
export 'check_rest_page_model.dart';



class CheckRestPageWidget extends StatefulWidget {
  const CheckRestPageWidget({super.key});

  @override
  State<CheckRestPageWidget> createState() => _CheckRestPageWidgetState();
}

class _CheckRestPageWidgetState extends State<CheckRestPageWidget> {
  late CheckRestPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckRestPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<PKBAppState>();

    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;
    double appBarHeight = 60.0/892.0 * MediaQuery.of(context).size.height;


    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PKBAppState().tertiaryColor,
        body: SafeArea(
          top: true,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: MediaQuery.of(context).size.height * 0.90,
                        child: widgets.CheckRestWidget(
                          width: MediaQuery.of(context).size.width * 1.0,
                          height: MediaQuery.of(context).size.height * 0.90,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: appBarHeight,
                  color: PKBAppState().tertiaryColor,
                  child: Semantics(
                    container: true,
                    label: '해당 물약의 잔량을 확인합니다.',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // This helps in distributing space evenly.
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0), // Add padding to the left of the text
                          child: Text(
                            '잔량 확인',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: appBarFontSize,
                              color: PKBAppState().secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(), // Pushes the button to the far right
                        const widgets.HomeButtonWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),),
          ),
      ),
    );

  }
}