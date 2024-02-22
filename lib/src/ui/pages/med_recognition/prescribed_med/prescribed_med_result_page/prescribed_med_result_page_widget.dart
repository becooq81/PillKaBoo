import '../../../../styles/pillkaboo_theme.dart';
import '../../../../../core/pillkaboo_util.dart';
import '../../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/semantics.dart';
import 'dart:ui' as ui;

import 'prescribed_med_result_page_model.dart';
export 'prescribed_med_result_page_model.dart';


class PrescribedMedResultPageWidget extends StatefulWidget {
  const PrescribedMedResultPageWidget({super.key});

  @override
  State<PrescribedMedResultPageWidget> createState() =>
      _CheckRestResultPageWidgetState();
}

class _CheckRestResultPageWidgetState extends State<PrescribedMedResultPageWidget> {
  late PrescribedMedResultPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrescribedMedResultPageModel());
    SemanticsService.announce("이 약은 ${PKBAppState().slotOfDay} 약입니다.", ui.TextDirection.ltr,);
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
    if (PKBAppState().slotOfDay == "아침") {
      imgPath = 'assets/images/morning.png';
    } else if (PKBAppState().slotOfDay == "점심") {
      imgPath = 'assets/images/lunch.png';
    } else if (PKBAppState().slotOfDay == "저녁") {
      imgPath = 'assets/images/night.png';
    } else {
      imgPath = 'assets/images/warning.svg';
      print("잔량 확인 결과 페이지에서 slotOfDay가 잘못 설정되었습니다.");
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
            label: '처방약 인식 결과',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '처방약 인식 결과',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '이 약은 ',
                      style: TextStyle(
                        color: PKBAppState().secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    TextSpan(
                      text: PKBAppState().slotOfDay,
                      style: TextStyle(
                        color: PKBAppState().primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    TextSpan(
                      text: ' 약입니다.',
                      style: TextStyle(
                        color: PKBAppState().secondaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              Image.asset(
                imgPath,
                height: 164.41,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}