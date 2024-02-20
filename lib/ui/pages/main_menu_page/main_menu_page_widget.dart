import '../../../../core/pillkaboo_theme.dart';
import '../../../../core/pillkaboo_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main_menu_page_model.dart';
export 'main_menu_page_model.dart';

class MainMenuPageWidget extends StatefulWidget {
  const MainMenuPageWidget({super.key});

  @override
  State<MainMenuPageWidget> createState() => _MainMenuPageWidgetState();
}

class _MainMenuPageWidgetState extends State<MainMenuPageWidget> {
  late MainMenuPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainMenuPageModel());
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

    double containerHeight = 111.0/892.0 * MediaQuery.of(context).size.height;
    double containerWidth = 353.0/412.0 * MediaQuery.of(context).size.width;
    double iconSize = 80.0/892.0 * MediaQuery.of(context).size.height;
    double textSize = 30.0/892.0 * MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PKBAppState().tertiaryColor,
        body: SafeArea(
          top: true,
            child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                  child: Semantics(
                    label: '약 인식',
                    child: Container(
                    width: containerWidth,
                    height: containerHeight,
                    decoration: BoxDecoration(
                      color: PKBAppState().tertiaryColor, // Background color
                      borderRadius: BorderRadius.circular(26.0),
                      border: Border.all(
                        color: PKBAppState().secondaryColor, // Border color
                        width: 1.0,
                      ),
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.go('/medRecognitionPage');
                      },
                      child: ExcludeSemantics(
                        excluding: true,
                        child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30.0, 0.0, 0.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: SvgPicture.asset(
                                'assets/images/main_menu_pill.svg',
                                width: iconSize,
                                height: iconSize,
                                fit: BoxFit.fitHeight,
                                colorFilter: ColorFilter.mode(
                                  PKBAppState().secondaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(child: Text(
                              '약 인식',
                              style: PillKaBooTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: PillKaBooTheme.of(context)
                                        .titleMediumFamily,
                                    color:
                                    PKBAppState().secondaryColor,
                                    fontSize: textSize,
                                    fontWeight: FontWeight.w900,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            PillKaBooTheme.of(context)
                                                .titleMediumFamily),
                                  ),),),
                          ),
                        ],
                      ),),
                    ),
                  ),),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                  child: Semantics(
                    label: '물약 복용 보조',
                    container: true,
                    child: Container(
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        color: PKBAppState().tertiaryColor, // Background color
                        borderRadius: BorderRadius.circular(26.0),
                        border: Border.all(
                          color: PKBAppState().secondaryColor, // Border color
                          width: 1.0,
                        ),
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.go('/liquidMedSubMenuPage');
                        },
                        child: ExcludeSemantics(
                          excluding: true,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    30.0, 0.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: SvgPicture.asset(
                                    'assets/images/Dose.svg',
                                    width: iconSize,
                                    height: iconSize,
                                    fit: BoxFit.fitHeight,
                                    colorFilter: ColorFilter.mode(
                                      PKBAppState().secondaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                  '물약 복용 보조',
                                  style: PillKaBooTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: PillKaBooTheme.of(context)
                                        .titleMediumFamily,
                                    color:
                                    PKBAppState().secondaryColor,
                                    fontSize: textSize,
                                    fontWeight: FontWeight.w900,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                        PillKaBooTheme.of(context)
                                            .titleMediumFamily),
                                ),
                              ),),),
                            ],
                          ),),
                      ),
                    ),),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                  child: Semantics(
                    label: '환경 설정',
                    container: true,
                    child: Container(
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        color: PKBAppState().tertiaryColor, // Background color
                        borderRadius: BorderRadius.circular(26.0),
                        border: Border.all(
                          color: PKBAppState().secondaryColor, // Border color
                          width: 1.0,
                        ),
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.go('/settingsMenuPage');
                        },
                        child: ExcludeSemantics(
                          excluding: true,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    30.0, 0.0, 0.0, 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: SvgPicture.asset(
                                    'assets/images/setting.svg',
                                    width: iconSize,
                                    height: iconSize,
                                    fit: BoxFit.fitHeight,
                                    colorFilter: ColorFilter.mode(
                                      PKBAppState().secondaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                  '환경 설정',
                                  style: PillKaBooTheme.of(context)
                                      .titleMedium
                                      .override(
                                    fontFamily: PillKaBooTheme.of(context)
                                        .titleMediumFamily,
                                    color:
                                    PKBAppState().secondaryColor,
                                    fontSize: textSize,
                                    fontWeight: FontWeight.w900,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                        PillKaBooTheme.of(context)
                                            .titleMediumFamily),
                                ),
                              ),),),
                            ],
                          ),),
                      ),
                    ),),
                ),
              ),
            ],
          ),),
        ),
    );
  }
}