import '../../../../core/pillkaboo_util.dart';
import '../../../styles/pillkaboo_theme.dart';
import '../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'liquid_med_submenu_page_model.dart';
export 'liquid_med_submenu_page_model.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LiquidMedSubMenuPageWidget extends StatefulWidget {
  const LiquidMedSubMenuPageWidget({super.key});

  @override
  State<LiquidMedSubMenuPageWidget> createState() =>
      _LiquidMedSubMenuPageWidgetState();
}

class _LiquidMedSubMenuPageWidgetState extends State<LiquidMedSubMenuPageWidget> {
  late LiquidMedSubMenuPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LiquidMedSubMenuPageModel());
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

    context.watch<PKBAppState>();

    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;
    double iconSize = 80.0/892.0 * MediaQuery.of(context).size.height;
    double textFontSize = 30.0/892.0 * MediaQuery.of(context).size.height;
    double containerHeight = 111.0/892.0 * MediaQuery.of(context).size.height;
    double containerWidth = 353.0/412.0 * MediaQuery.of(context).size.width;

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
            label: '물약 복용 보조 메뉴',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '물약 복용 보조 메뉴',
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
                    container: true,
                    child: GestureDetector(
                      onTap: () async {
                        context.pushReplacement('/pourRightSliderPage');
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
                                  'assets/images/liquid_sub_pouring.svg',
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
                              child: Text(
                              '물약 따르기',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                color: PKBAppState().secondaryColor,
                                fontSize: textFontSize,
                                fontWeight: FontWeight.w900,
                              ),
                            ),),),
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
                    child: GestureDetector(
                      onTap: () async {
                        context.pushReplacement('/checkRestPage');
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
                                  'assets/images/rest.svg',
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
                              child: Text(
                              '잔량 확인',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                color: PKBAppState().secondaryColor,
                                fontSize: textFontSize,
                                fontWeight: FontWeight.w900,
                              ),
                            ),),),
                        ],
                      ),
                    ),),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}