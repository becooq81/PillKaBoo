import 'dart:async';

import '../../../../core/pillkaboo_util.dart';
import '../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'pour_right_page_model.dart';
export 'pour_right_page_model.dart';


class PourRightPageWidget extends StatefulWidget {
  const PourRightPageWidget({super.key});

  @override
  State<PourRightPageWidget> createState() => _PourRightPageWidgetState();
}

class _PourRightPageWidgetState extends State<PourRightPageWidget> {
  late PourRightPageModel _model;
  final StreamController<bool> _controller = StreamController();

  

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller.stream.listen((success) {
      if (success) {
        if (mounted) {
          context.pushReplacement('/pourRightResultPage');
        }
      }
    });
    _model = createModel(context, () => PourRightPageModel());
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

    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;
    double appBarHeight = 60.0/892.0 * MediaQuery.of(context).size.height;

    context.watch<PKBAppState>();

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
            child:Stack(
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
                        child: widgets.PourRightWidget(
                          width: MediaQuery.of(context).size.width * 1.0,
                          height: MediaQuery.of(context).size.height * 0.90,
                          controller: _controller,
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
                    label: '카메라를 고정해주세요. ${PKBAppState().pourAmount}ml 소분을 시작합니다.',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '물약 따르기',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: appBarFontSize,
                              color: PKBAppState().secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
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