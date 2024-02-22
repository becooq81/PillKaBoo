import '../../../styles/pillkaboo_theme.dart';
import '../../../../core/pillkaboo_util.dart';
import '../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/semantics.dart';
import 'dart:ui' as ui;

import 'check_rest_result_page_model.dart';
export 'check_rest_result_page_model.dart';


class CheckRestResultPageWidget extends StatefulWidget {
  const CheckRestResultPageWidget({super.key});

  @override
  State<CheckRestResultPageWidget> createState() =>
      _CheckRestResultPageWidgetState();
}

class _CheckRestResultPageWidgetState extends State<CheckRestResultPageWidget> {
  late CheckRestResultPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckRestResultPageModel());
    if (PKBAppState().isRestAmountRecognized) {
      SemanticsService.announce("현재 남은 물약의 양은 ${PKBAppState().pourAmount} ml입니다.", ui.TextDirection.ltr,);
    } else {
      SemanticsService.announce("용기 불투명해 인식할 수 없어요.", ui.TextDirection.ltr,);
    }
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
          statusBarBrightness: Theme
              .of(context)
              .brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    String imgPath;
    if (PKBAppState().isRestAmountRecognized) {
      imgPath = 'assets/images/Group79.png';
    } else {
      imgPath = 'assets/images/Group81.png';
    }


    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;


    context.watch<PKBAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PKBAppState().tertiaryColor,
        appBar: AppBar(
          backgroundColor: PKBAppState().tertiaryColor,
          automaticallyImplyLeading: false, 
          title: Semantics(
            container: true,
            label: '잔량 확인 결과',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '잔량 확인 결과',
                style: PillKaBooTheme.of(context).headlineMedium.override(
                  fontFamily: PillKaBooTheme.of(context).headlineMediumFamily,
                  color: PKBAppState().secondaryColor,
                  fontSize: appBarFontSize,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(PillKaBooTheme.of(context).headlineMediumFamily),
                ),
              ),
            ),
          ),
          actions: const [
            widgets.HomeButtonWidget(),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (PKBAppState().isRestAmountRecognized)
                Text(
                  '현재 남은 물약의 양은',
                  style: TextStyle(
                    color: PKBAppState().secondaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                  )
              else
                Text(
                  '인식이 되지 않았어요.',
                  style: TextStyle(
                    color: PKBAppState().primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                  ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                imgPath,
                height: 164.41,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 10,
              ),
              if (PKBAppState().isRestAmountRecognized)
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '${PKBAppState().pourAmount}',
                        style: TextStyle(
                          fontSize: 60.0,
                          color: PKBAppState().primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                          ),
                        ),
                        TextSpan(
                          text: ' ml', 
                          style: TextStyle(
                            fontSize: 30.0,
                            color: PKBAppState().secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pretendard'
                          ),
                        ),
                      ],
                    ),
                  )
              else
                Column(
                  children: [
                    Text(
                      '용기 불투명해',
                      style: TextStyle(
                        color: PKBAppState().secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        ),
                      ),
                    Text(
                      '인식할 수 없어요.',
                      style: TextStyle(
                        color: PKBAppState().secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                        ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}