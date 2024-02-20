import '../../../widgets/index.dart' as widgets;
import '../../../../core/pillkaboo_theme.dart';
import '../../../../core/pillkaboo_util.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'help_page_model.dart';
export 'help_page_model.dart';


class HelpPageWidget extends StatefulWidget {
  const HelpPageWidget({super.key});
  @override
  State<HelpPageWidget> createState() => _HelpPageWidgetState();
}
class _HelpPageWidgetState extends State<HelpPageWidget> {
  late HelpPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String howToRecognizeMedicine = "약 인식 홈 화면에서 약 인식 버튼을 누르고, 카메라에서 30cm를 떨어져서 약의 곽을 천천히 돌려가며 비춰주세요. 약정보와 유통기한이 각각 인식이 되었을 때 진동이 울리고, 진동이 두번 울려 모두 인식이 완료되면 성공음과 함께 약의 이름을 읽어드립니다. 버튼을 넘겨가며 정보를 확인해보세요.";
  String howToPourRight = "물약 따르기 홈 화면에서 물약 복용 보조 버튼을 누르고, 다음 화면에서 물약 따르기 버튼을 눌러주세요. 슬라이더를 조절하여 물약의 양을 설정하시고, 확인 버튼을 눌러 카메라 인식을 시작해주세요. 카메라를 고정하시고 기계음 피드백에 맞춰 약을 따라주세요. 완료 후에는 잔량 확인 버튼으로 따른 물약의 양을 확인할 수 있습니다.";
  String howToCheckLeft = "잔량 확인 홈 화면에서 물약 복용 보조 버튼을 누르고, 다음 화면에서 잔량 확인 버튼을 눌러주세요. 인식이 완료되면 잔량을 알려드립니다.";
  String howToAddAllergies = "알러지 성분 설정 홈 화면에서 환경 설정 버튼을 누르고, 다음 화면에서 알러지 성분 설정 버튼을 눌러주세요. 추가하기 버튼으로 알러지 성분을 등록하고 관리하세요. 등록된 성분은 인식된 약의 주성분일 경우에 아이 관련 주의사항으로 안내드립니다.";
  String howToChangeColor = "색상 설정 홈 화면에서 환경 설정 버튼을 누르고, 다음 화면에서 색상 설정 버튼을 눌러주세요. 원하시는 색상의 버튼을 누르면 배경, 대비, 강조 색상을 고르실 수 있습니다.";

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HelpPageModel());
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
    double imageContainerSize = 85.0/892.0 * MediaQuery.of(context).size.height;
    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;
    double textFontSize = 30.0/892.0 * MediaQuery.of(context).size.height;
    double paddingBelowAppBar = 25.0/892.0 * MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PKBAppState().tertiaryColor,
        appBar: AppBar(
          backgroundColor: PKBAppState().tertiaryColor,
          automaticallyImplyLeading: false, // Keep this if you don't want the default back button to appear
          title: Semantics(
            container: true,
            label: '도움말',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '도움말',
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.87,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Semantics(
                    container: true,
                    label: howToRecognizeMedicine,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, paddingBelowAppBar, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ExcludeSemantics(
                            excluding: true,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 40.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  width: imageContainerSize,
                                  height: imageContainerSize,
                                  decoration: BoxDecoration(
                                    color: PKBAppState().secondaryColor, // Set the background color to white
                                    shape: BoxShape.circle, // Set the container shape as circle
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0), // Adjust padding as needed
                                    child: SvgPicture.asset(
                                      'assets/images/main_menu_pill.svg',
                                      fit: BoxFit.contain,
                                      colorFilter: ColorFilter.mode(
                                        PKBAppState().tertiaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ExcludeSemantics(
                            excluding: true,
                            child: Text(
                              '약 인식',
                              style: PillKaBooTheme.of(context).titleMedium.override(
                                fontFamily:
                                PillKaBooTheme.of(context).titleMediumFamily,
                                fontSize: textFontSize,
                                color: PKBAppState().secondaryColor,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    PillKaBooTheme.of(context).titleMediumFamily),
                              ),
                            ),
                          ),
                        ],
                      ),)
                ),
                Semantics(
                  container: true,
                  label: howToPourRight,
                  child: InkWell(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ExcludeSemantics(
                          excluding: true,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 40.0, 0.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                width: imageContainerSize,
                                height: imageContainerSize,
                                decoration: BoxDecoration(
                                  color: PKBAppState().secondaryColor, // Set the background color
                                  shape: BoxShape.circle, // Circular shape
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                                  child: SvgPicture.asset(
                                    'assets/images/liquid_sub_pouring.svg',
                                    fit: BoxFit.contain,
                                    colorFilter: ColorFilter.mode(
                                      PKBAppState().tertiaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ExcludeSemantics(
                          excluding: true,
                          child: Text(
                            '물약 따르기',
                            style: PillKaBooTheme.of(context).titleMedium.override(
                              fontFamily:
                              PillKaBooTheme.of(context).titleMediumFamily,
                              fontSize: textFontSize,
                              color: PKBAppState().secondaryColor,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  PillKaBooTheme.of(context).titleMediumFamily),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Semantics(
                  container: true,
                  label: howToCheckLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ExcludeSemantics(
                        excluding: true,
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 40.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: imageContainerSize,
                              height: imageContainerSize,
                              decoration: BoxDecoration(
                                color: PKBAppState().secondaryColor, // Set the background color
                                shape: BoxShape.circle, // Circular shape
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0), // Adjust padding as needed
                                child: SvgPicture.asset(
                                  'assets/images/rest.svg',
                                  fit: BoxFit.contain,
                                  colorFilter: ColorFilter.mode(
                                    PKBAppState().tertiaryColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ExcludeSemantics(
                        excluding: true,
                        child: Text(
                          '잔량 확인',
                          style: PillKaBooTheme.of(context).titleMedium.override(
                            fontFamily:
                            PillKaBooTheme.of(context).titleMediumFamily,
                            fontSize: textFontSize,
                            color: PKBAppState().secondaryColor,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                PillKaBooTheme.of(context).titleMediumFamily),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Semantics(
                  container: true,
                  label: howToAddAllergies,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ExcludeSemantics(
                        excluding: true,
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 40.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: imageContainerSize,
                              height: imageContainerSize,
                              decoration: BoxDecoration(
                                color: PKBAppState().secondaryColor, // Set the background color
                                shape: BoxShape.circle, // Circular shape
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                                child: SvgPicture.asset(
                                  'assets/images/allergy.svg',
                                  fit: BoxFit.contain,
                                  colorFilter: ColorFilter.mode(
                                    PKBAppState().tertiaryColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ExcludeSemantics(
                        excluding: true,
                        child: Text(
                          '알러지 성분 설정',
                          style: PillKaBooTheme.of(context).titleMedium.override(
                            fontFamily:
                            PillKaBooTheme.of(context).titleMediumFamily,
                            fontSize: textFontSize,
                            fontWeight: FontWeight.bold,
                            color: PKBAppState().secondaryColor,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                PillKaBooTheme.of(context).titleMediumFamily),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Semantics(
                  container: true,
                  label: howToChangeColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ExcludeSemantics(
                        excluding: true,
                        child: Padding(
                          padding:
                          const EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 40.0, 0.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              width: imageContainerSize,
                              height: imageContainerSize,
                              decoration: BoxDecoration(
                                color: PKBAppState().secondaryColor, // Set the background color
                                shape: BoxShape.circle, // Circular shape
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0), // Adjust padding as needed
                                child: SvgPicture.asset(
                                  'assets/images/Palette.svg',
                                  fit: BoxFit.contain,
                                  colorFilter: ColorFilter.mode(
                                    PKBAppState().tertiaryColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ExcludeSemantics(
                        excluding: true,
                        child: Text(
                          '색상 설정',
                          style: PillKaBooTheme.of(context).titleMedium.override(
                            fontFamily:
                            PillKaBooTheme.of(context).titleMediumFamily,
                            fontSize: textFontSize,
                            color: PKBAppState().secondaryColor,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                PillKaBooTheme.of(context).titleMediumFamily),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}