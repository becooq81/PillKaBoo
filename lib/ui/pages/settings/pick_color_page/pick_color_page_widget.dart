import '../../../../core/pillkaboo_theme.dart';
import '../../../../core/pillkaboo_util.dart';
import '../../../widgets/index.dart' as widgets;
import '../../../../app/global_audio_player.dart';

import 'package:vibration/vibration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pick_color_page_model.dart';
export 'pick_color_page_model.dart';


class PickColorPageWidget extends StatefulWidget {
  const PickColorPageWidget({super.key});

  @override
  State<PickColorPageWidget> createState() => _PickColorPageWidgetState();
}

class _PickColorPageWidgetState extends State<PickColorPageWidget> {
  late PickColorPageModel _model;
  Color selectedPrimary = PKBAppState().primaryColor; // Emphasis color
  Color selectedSecondary = PKBAppState().secondaryColor; // Contrast color
  Color selectedTertiary = PKBAppState().tertiaryColor; // Background color

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PickColorPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // System UI overlay style for iOS (optional)
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Close the keyboard when tapping outside
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PKBAppState().tertiaryColor,
        appBar: AppBar(
          backgroundColor: PKBAppState().tertiaryColor,
          automaticallyImplyLeading: false, // Keep this if you don't want the default back button to appear
          title: Semantics(
            container: true,
            label: '색상 설정',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '색상 설정',
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130.0,
                  padding: const EdgeInsets.all(3.0), // Add padding to all sides
                  decoration: BoxDecoration(
                    color: PKBAppState().tertiaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            '배경 색상',
                            style: PillKaBooTheme.of(context).headlineMedium.override(
                              fontFamily: PillKaBooTheme.of(context).headlineMediumFamily,
                              color: PKBAppState().secondaryColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  PillKaBooTheme.of(context).headlineMediumFamily),
                            ),
                          ),),
                      ),
                      buildColorRow(0, ['검은색', '흰색'], 2),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  padding: const EdgeInsets.all(5.0), // Add padding to all sides
                  decoration: BoxDecoration(
                    color: PKBAppState().tertiaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                          '대비 색상',
                          style: PillKaBooTheme.of(context).headlineMedium.override(
                            fontFamily: PillKaBooTheme.of(context).headlineMediumFamily,
                            color: PKBAppState().secondaryColor,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                PillKaBooTheme.of(context).headlineMediumFamily),
                          ),
                        ),),
                      ),
                      buildColorRow(0, ['검은색', '흰색', '회색'], 1),
                      buildColorRow(3, ['파란색', '빨간색', '노란색'], 1),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  padding: const EdgeInsets.all(5.0), // Add padding to all sides
                  decoration: BoxDecoration(
                    color: PKBAppState().tertiaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            '강조 색상',
                            style: PillKaBooTheme.of(context).headlineMedium.override(
                              fontFamily: PillKaBooTheme.of(context).headlineMediumFamily,
                              color: PKBAppState().secondaryColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  PillKaBooTheme.of(context).headlineMediumFamily),
                            ),
                          ),),
                      ),
                      buildColorRow(0, ['검은색', '흰색', '회색'], 0),
                      buildColorRow(3, ['파란색', '빨간색', '노란색'],0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildColorRow(int startIndex, List<String> colors, int appColorIndex) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(colors.length, (index) {
          Color containerColor = getColorFromName(colors[index]); // Get the color object based on the name

          bool isSelected;
          if (appColorIndex == 0) {
            isSelected = containerColor == PKBAppState().primaryColor;
          } else if (appColorIndex == 1) {
            isSelected = containerColor == PKBAppState().secondaryColor;
          } else { // appColorIndex == 2
            isSelected = containerColor == PKBAppState().tertiaryColor;
          }

          return GestureDetector(
            onTap: () {
              Vibration.vibrate();
              setState(() {
                if (appColorIndex == 0) {
                  GlobalAudioPlayer().playOnce();
                  PKBAppState().primaryColor = containerColor;
                } else if (appColorIndex == 1) {
                  GlobalAudioPlayer().playOnce();
                  PKBAppState().secondaryColor = containerColor;
                } else if (appColorIndex == 2) {
                  GlobalAudioPlayer().playOnce();
                  PKBAppState().tertiaryColor = containerColor;
                }
              });
            },
            child: Container(
              width: 90.0,
              height: 75.0,
              margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(26.0),
                border: isSelected ? Border.all(color: Colors.greenAccent, width: 4.0) : null,
              ),
              alignment: Alignment.center,
              child: Text(
                colors[index],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: colors[index] == '검은색' ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }


  Color getColorFromName(String colorName) {
    switch (colorName) {
      case '검은색':
        return Colors.black;
      case '흰색':
        return Colors.white;
      case '회색':
        return const Color(0xFF797676);
      case '파란색':
        return const Color(0xFF4285F4);
      case '빨간색':
        return const Color(0xFFFF0132);
      case '노란색':
        return const Color(0xFFF9E000);
      default:
        return Colors.transparent; // Fallback color
    }
  }

}