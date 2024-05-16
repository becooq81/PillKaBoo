import 'package:pillkaboo/src/data/local/shared_preference/app_state.dart';

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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccessibilityChoicePageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _handleTap(BuildContext context, bool isYes) {
    final response = isYes ? "예" : "아니오";
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("You selected: $response")),
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
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            '스크린리더 사용',
                            style: TextStyle(
                                fontSize: textSize,
                                color: PKBAppState().secondaryColor,
                                decoration: TextDecoration.none,
                              ),
                            )
                          ),
                        ),
                      Expanded(
                        child: Center(
                          child: Text(
                            '스크린리더 사용 안함',
                            style: TextStyle(
                                fontSize: textSize,
                                color: PKBAppState().secondaryColor,
                                decoration: TextDecoration.none,
                              ),
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