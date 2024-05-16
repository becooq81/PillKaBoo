import 'package:pillkaboo/src/app/tts/tts_service.dart';

import '../../../styles/pillkaboo_theme.dart';
import '../../../../core/pillkaboo_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'accessibility_choice_page_model.dart';
export 'accessibility_choice_page_model.dart';

class AccessibilityChoicePageWidget extends StatefulWidget {
  const AccessibilityChoicePageWidget({super.key});

  @override
  State<AccessibilityChoicePageWidget> createState() => _AccessibilityChoicePageWidgetState();
}

class _AccessibilityChoicePageWidgetState extends State<AccessibilityChoicePageWidget> {
  late AccessibilityChoicePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final text = "스크린 리더를 사용하시면 화면 상단을, 사용하지 않으시면 화면 하단을 눌러주세요.";

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccessibilityChoicePageModel());
    TtsService().speak(text);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _handleTap(BuildContext context, bool isYes) {
    final response = isYes ? "스크린 리더 사용" : "스크린 리더 사용 안함";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$response을 선택하셨습니다.")),
    );
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


    double textSize = 35.0/892.0 * MediaQuery.of(context).size.height;

    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        final screenHeight = MediaQuery.of(context).size.height;
        final tapPosition = details.globalPosition.dy;
        if (tapPosition < screenHeight / 2) {
          _handleTap(context, true); // uses screen reader, hence NO tts
          PKBAppState().useScreenReader = true;
        } else {
          _handleTap(context, false); // doesn't use screen reader, hence TTS
          PKBAppState().useScreenReader = false;
        }
        PKBAppState().isFirstLaunch = false;
        context.push('/mainMenuPage');
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PKBAppState().tertiaryColor,
        body: SafeArea(
          top: true,
            child: 
                Container(
                  color: PKBAppState().tertiaryColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: ExcludeSemantics(
                            excluding: true,
                            child: Text(
                            '스크린리더 사용',
                            style: TextStyle(
                                fontSize: textSize,
                                color: PKBAppState().secondaryColor,
                                decoration: TextDecoration.none,
                              ),
                            )
                          )
                          ),
                        ),
                      Expanded(
                        child: Center(
                          child: ExcludeSemantics(
                            excluding: true,
                            child: Text(
                            '스크린리더 사용 안함',
                            style: TextStyle(
                                fontSize: textSize,
                                color: PKBAppState().secondaryColor,
                                decoration: TextDecoration.none,
                              ),
                            )
                          )
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}