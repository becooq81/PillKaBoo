import 'package:pillkaboo/src/app/tts/tts_service.dart';

import '../../../styles/pillkaboo_theme.dart';
import '../../../../core/pillkaboo_util.dart';
import '../../../widgets/index.dart' as widgets;
import '../../../../app/global_audio_player.dart';

import 'package:vibration/vibration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'control_tts_page_model.dart';
export 'control_tts_page_model.dart';

class ControlTTSPageWidget extends StatefulWidget {
  const ControlTTSPageWidget({super.key});

  @override
  State<ControlTTSPageWidget> createState() => _ControlTTSPageWidgetState();
}

class _ControlTTSPageWidgetState extends State<ControlTTSPageWidget> {
  late ControlTTSPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ControlTTSPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    double appBarFontSize = 32.0 / 892.0 * MediaQuery.of(context).size.height;
    double sliderValue = PKBAppState().ttsSpeed;
    final double textSize = 24.0 / 892.0 * MediaQuery.of(context).size.height;
    final List<double> values = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
    int selectedIndex = values.indexOf(sliderValue);
    String controlTxt = "현재 스크린 리더를 사용하고 계십니다. 스크린 리더를 끄시고 앱 자체 오디오를 사용하려면 터치하세요.";
    if (!PKBAppState().useScreenReader) {
      controlTxt = "현재 스크린 리더를 사용하지 않고 계십니다. 스크린 리더를 사용하시려면 터치하세요.";
    }

    void handleSliderChange(double value) {
      setState(() {
        sliderValue = value;
        PKBAppState().ttsSpeed = value;
        TtsService().stop();
        TtsService().speak("${value.toStringAsFixed(1)} 속도입니다.");
        TtsService().setTtsSpeed(value);
      });
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Close the keyboard when tapping outside
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PKBAppState().tertiaryColor,
        appBar: AppBar(
          backgroundColor: PKBAppState().tertiaryColor,
          automaticallyImplyLeading: false, // prevent default back button from appearing
          title: Semantics(
            container: true,
            label: '오디오 설정',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '오디오 설정',
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
          actions: [
            widgets.HomeButtonWidget(),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0),
                Semantics(
                  label: controlTxt,
                  container: true,
                  child: ExcludeSemantics(
                    excluding: true,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          PKBAppState().useScreenReader = !PKBAppState().useScreenReader;
                          if (!PKBAppState().useScreenReader) {
                            TtsService().stop();
                            TtsService().speak("스크린 리더를 사용하지 않습니다.");
                          } else {
                            TtsService().stop();
                            //TtsService().speak("스크린 리더를 사용합니다.");
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '스크린 리더 사용 여부',
                              style: TextStyle(
                                fontSize: 27,
                                color: PKBAppState().secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Switch(
                              value: PKBAppState().useScreenReader,
                              focusColor: PKBAppState().primaryColor,
                              activeColor: PKBAppState().primaryColor,
                              onChanged: (bool value) {
                                setState(() {
                                  PKBAppState().useScreenReader = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                if (!PKBAppState().useScreenReader)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Semantics(
                              container: true,
                              child: Text(
                                '텍스트 읽기 기능 끄기',
                                style: TextStyle(
                                  fontSize: 27,
                                  color: PKBAppState().secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Switch(
                              value: PKBAppState().silentMode,
                              focusColor: PKBAppState().primaryColor,
                              activeColor: PKBAppState().primaryColor,
                              onChanged: (bool value) {
                                setState(() {
                                  PKBAppState().silentMode = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Semantics(
                        container: true,
                        label: '오디오 속도를 조절하시려면 스크린 리더 사용을 중지해주세요',
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Optional padding
                          child: Text(
                            '현재 오디오 속도: $sliderValue',
                            style: TextStyle(
                              fontSize: textSize,
                              color: PKBAppState().secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ExcludeSemantics(
                        excluding: true,
                        child: Slider(
                          value: selectedIndex.toDouble(),
                          min: 0,
                          max: values.length - 1.toDouble(),
                          divisions: values.length - 1,
                          label: values[selectedIndex].toString(),
                          activeColor: PKBAppState().primaryColor,
                          onChanged: (double value) {
                            setState(() {
                              selectedIndex = value.toInt();
                              handleSliderChange(values[selectedIndex]);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
