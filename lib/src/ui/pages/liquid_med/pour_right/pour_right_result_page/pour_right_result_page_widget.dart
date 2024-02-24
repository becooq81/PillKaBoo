import 'package:flutter/widgets.dart';

import '../../../../styles/pillkaboo_theme.dart';
import '../../../../../core/pillkaboo_util.dart';
import '../../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pour_right_result_page_model.dart';
export 'pour_right_result_page_model.dart';
import 'package:flutter/semantics.dart';
import 'dart:ui' as ui;

class PourRightResultPageWidget extends StatefulWidget {
  const PourRightResultPageWidget({super.key});

  @override
  State<PourRightResultPageWidget> createState() =>
      _PourRightResultPageWidgetState();
}

class _PourRightResultPageWidgetState extends State<PourRightResultPageWidget> {
  late PourRightResultPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PourRightResultPageModel());
    SemanticsService.announce("물약 소분을 완료했습니다.", ui.TextDirection.ltr,);
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
            label: '물약 따르기 결과',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '물약 따르기 결과',
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
          child: Center(
            child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 250.0),
                child: Image.asset(
                'assets/images/pour_done.png',
                height: 230,
                fit: BoxFit.contain,
              ),),
              
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                width: 400,
                child: ElevatedButton(
                onPressed: () {
                  context.pushReplacement('/checkRestPage');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    PKBAppState().tertiaryColor, 
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26), 
                      side: BorderSide(
                        color: PKBAppState().secondaryColor, 
                        width: 2.0, 
                      ),
                    ),
                  ),
                ),
                
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('잔량 확인',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: PKBAppState().secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                ),
              ),),),
              ),
            ],
          ),),
        ),
      ),
    );
  }
}