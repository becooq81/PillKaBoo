import '../../../widgets/index.dart' as widgets;
import '../../../styles/pillkaboo_theme.dart';
import '../../../../core/pillkaboo_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'settings_menu_page_model.dart';
export 'settings_menu_page_model.dart';



class SettingsMenuPageWidget extends StatefulWidget {
  const SettingsMenuPageWidget({super.key});

  @override
  State<SettingsMenuPageWidget> createState() => _SettingsMenuPageWidgetState();
}

class _SettingsMenuPageWidgetState extends State<SettingsMenuPageWidget> {
  late SettingsMenuPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsMenuPageModel());
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
    double iconSize = 75.0/892.0 * MediaQuery.of(context).size.height;
    double textSize = 28.0/892.0 * MediaQuery.of(context).size.height;
    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;

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
            label: '환경 설정 메뉴',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '환경 설정 메뉴',
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
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                  child: Semantics(
                    label: '알러지 성분 설정',
                    container: true,
                    child: GestureDetector(
                      onTap: () async {
                        context.pushReplacement('/allergyListPage');
                      },
                      child: Container(
                        width: containerWidth,
                        height: containerHeight,
                        decoration: BoxDecoration(
                          color: PKBAppState().tertiaryColor,
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(
                            color: PKBAppState().secondaryColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  30.0, 0.0, 0.0, 0.0),
                              child: ExcludeSemantics(
                                excluding: true,
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: SvgPicture.asset(
                                  'assets/images/allergy.svg',
                                  width: iconSize,
                                  height: iconSize,
                                  fit: BoxFit.fitHeight,
                                  colorFilter: ColorFilter.mode(
                                    PKBAppState().secondaryColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),),
                            ),
                            Expanded(
                              child: Center(
                                child: ExcludeSemantics(
                                  excluding: true,
                                  child: Text(
                                    '알러지 성분 설정',
                                    style: PillKaBooTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: PillKaBooTheme.of(context)
                                              .titleMediumFamily,
                                          color: PKBAppState().secondaryColor,
                                          fontSize: textSize,
                                          fontWeight: FontWeight.w900,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(PillKaBooTheme.of(context)
                                                  .titleMediumFamily
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                  child: Semantics(
                    container: true,
                    label: "색상 설정",
                    explicitChildNodes: false,
                    child: GestureDetector(
                      onTap: () async {
                        context.pushReplacement('/pickColorPage');
                      },
                      child: Container(
                        width: containerWidth,
                        height: containerHeight,
                        decoration: BoxDecoration(
                          color: PKBAppState().tertiaryColor,
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(
                            color: PKBAppState().secondaryColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  30.0, 0.0, 0.0, 0.0),
                              child: ExcludeSemantics(
                                excluding: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: SvgPicture.asset(
                                    'assets/images/Palette.svg',
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
                            ),
                            Expanded(
                              child: Center(
                                child: ExcludeSemantics(
                                  excluding: true,
                                  child: Text(
                                    '색상 설정',
                                    style: PillKaBooTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: PillKaBooTheme.of(context)
                                              .titleMediumFamily,
                                          color: PKBAppState().secondaryColor,
                                          fontSize: textSize,
                                          fontWeight: FontWeight.w900,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(PillKaBooTheme.of(context)
                                                  .titleMediumFamily),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 50.0),
                  child: Semantics(
                    container: true,
                    label: "오디오 속도 설정",
                    explicitChildNodes: false,
                    child: GestureDetector(
                      onTap: () async {
                        context.pushReplacement('/controlTTSPage');
                      },
                      child: Container(
                        width: containerWidth,
                        height: containerHeight,
                        decoration: BoxDecoration(
                          color: PKBAppState().tertiaryColor,
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(
                            color: PKBAppState().secondaryColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  30.0, 0.0, 0.0, 0.0),
                              child: ExcludeSemantics(
                                excluding: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: SvgPicture.asset(
                                    'assets/images/speaker.svg',
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
                            ),
                            Expanded(
                              child: Center(
                                child: ExcludeSemantics(
                                  excluding: true,
                                  child: Text(
                                    '오디오 속도 설정',
                                    style: PillKaBooTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: PillKaBooTheme.of(context)
                                              .titleMediumFamily,
                                          color: PKBAppState().secondaryColor,
                                          fontSize: textSize,
                                          fontWeight: FontWeight.w900,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(PillKaBooTheme.of(context)
                                                  .titleMediumFamily),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}