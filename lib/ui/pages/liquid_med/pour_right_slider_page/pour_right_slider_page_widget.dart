import '../../../../core/pillkaboo_util.dart';
import '../../../../ui/common/pillkaboo_theme.dart';
import '../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/semantics.dart';
import 'dart:ui' as ui;

import 'pour_right_slider_page_model.dart';
export 'pour_right_slider_page_model.dart';


class PourRightSliderPageWidget extends StatefulWidget {
  const PourRightSliderPageWidget({super.key});

  @override
  State<PourRightSliderPageWidget> createState() =>
      _PourRightSliderPageWidgetState();
}

class _PourRightSliderPageWidgetState extends State<PourRightSliderPageWidget> {
  late PourRightSliderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int currentValue = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PourRightSliderPageModel());
    SemanticsService.announce("슬라이더로 이동해 복용량을 조절해주세요.", ui.TextDirection.ltr,);
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
          title: ExcludeSemantics(
              excluding: true,
              child: Text(
                '물약 따르기',
                style: PillKaBooTheme.of(context).headlineMedium.override(
                  fontFamily: PillKaBooTheme.of(context).headlineMediumFamily,
                  color: PKBAppState().secondaryColor,
                  fontSize: appBarFontSize,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(PillKaBooTheme.of(context).headlineMediumFamily),
                ),
              ),
            ),
          actions: const [
            widgets.HomeButtonWidget(),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: Stack(
          children: [
            Align(
              alignment: const FractionalOffset(0.5, 0.4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ExcludeSemantics(
                    excluding: true,
                    child: RichText(
                    text: TextSpan(
                    children: <TextSpan>[
                    TextSpan(
                    text: '$currentValue',
                      style: TextStyle(
                        fontSize: 60.0,
                        color: PKBAppState().primaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                      TextSpan(
                        text: ' ml', // Text part 2
                        style: TextStyle(
                            fontSize: 30.0,
                            color: PKBAppState().secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pretendard'
                        ),
                      ),
                      ],
                    ),
                  ),),
                  const SizedBox(height: 20), // Add some spacing between the text and the slider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                            Icons.remove,
                            color: PKBAppState().secondaryColor,
                            size: 30.0,
                          ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: widgets.GestureSlider(
                          minValue: 0,
                          maxValue: 30,
                          initialValue: currentValue, // Use the state's currentValue as the initial value
                          onValueChanged: (newValue) {
                            setState(() {
                              currentValue = newValue; // Update the state's currentValue with the new value from the slider
                            });
                          },
                        ),
                      ),
                      Icon(
                            Icons.add,
                            color: PKBAppState().secondaryColor,
                            size: 30.0,
                          )
                    ],
                  ),
                ],
              ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 75.0,
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: () {
                  PKBAppState().pourAmount = currentValue;
                  context.go('/pourRightPage');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    PKBAppState().tertiaryColor, // Background color
                  ),
                  // Adjust the shape for a fully rounded border
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26), // Fully rounded border
                      side: BorderSide(
                        color: PKBAppState().secondaryColor, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                  ),
                ),
                child: Text('확인',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: PKBAppState().secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                  ),
                ),
              ),
            ),
          ),),
        ],
      ),
      ),
    );
  }
}