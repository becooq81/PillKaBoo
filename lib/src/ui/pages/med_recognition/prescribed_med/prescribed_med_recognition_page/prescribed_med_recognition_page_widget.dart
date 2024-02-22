import 'dart:async';

import '../../../../../core/pillkaboo_util.dart';
import '../../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'prescribed_med_recognition_page_model.dart';
export 'prescribed_med_recognition_page_model.dart';


class PrescribedMedRecognitionPageWidget extends StatefulWidget {
  const PrescribedMedRecognitionPageWidget({super.key});

  @override
  State<PrescribedMedRecognitionPageWidget> createState() => _PrescribedMedRecognitionPageWidgetState();
}

class _PrescribedMedRecognitionPageWidgetState extends State<PrescribedMedRecognitionPageWidget> {
  late PrescribedMedRecognitionPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final StreamController<bool> _controller = StreamController();


  @override
  void initState() {
    super.initState();
    _controller.stream.listen((success) {
      if (success) {
        if (mounted) {
          context.pushReplacement('/prescribedMedResultPage');
        }
      }
    });
    PKBAppState().slotOfDay = "";
    _model = createModel(context, () => PrescribedMedRecognitionPageModel());
  }



  @override
  void dispose() {
    _model.dispose();
    _controller.close();
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

    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;
    double appBarHeight = 60.0/892.0 * MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: PKBAppState().tertiaryColor,
        body: SafeArea(
          top: true,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: MediaQuery.of(context).size.height * 0.90,
                        child: widgets.PrescribedMedRecognizerWidget(
                          width: MediaQuery.of(context).size.width * 1.0,
                          height: MediaQuery.of(context).size.height * 0.90,
                          controller: _controller,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: appBarHeight,
                  color: PKBAppState().tertiaryColor,
                  child: Semantics(
                    container: true,
                    label: '카메라에서 30cm를 떨어져서 하나의 처방약을 비추고, 뒤집은 후 다시 비춰주세요.',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '처방약 인식',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: appBarFontSize,
                              color: PKBAppState().secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const widgets.HomeButtonWidget(),
                      ],
                    ),
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