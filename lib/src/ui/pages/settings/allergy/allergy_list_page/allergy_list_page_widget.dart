import '../../../../../core/pillkaboo_util.dart';
import '../../../../styles/pillkaboo_theme.dart';
import '../../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'allergy_list_page_model.dart';
export 'allergy_list_page_model.dart';

class AllergyListPageWidget extends StatefulWidget {
  const AllergyListPageWidget({super.key});

  @override
  State<AllergyListPageWidget> createState() => _AllergyListPageWidgetState();
}

class _AllergyListPageWidgetState extends State<AllergyListPageWidget> {
  late AllergyListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllergyListPageModel());
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

    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;
    double backIconSize = 30.0/892.0 * MediaQuery.of(context).size.height;

    context.watch<PKBAppState>();

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
            label: '알러지 성분 설정',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '알러지 성분 설정',
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    context.pushReplacement('/allergyAddPage');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: 52.35,
                      decoration: BoxDecoration(
                        color: PKBAppState().tertiaryColor, // Background color
                        borderRadius: BorderRadius.circular(26.0),
                        border: Border.all(
                          color: PKBAppState().secondaryColor, // Border color
                          width: 1.0,
                        ),
                      ),
                alignment: const Alignment(0, 0),
                child: Text(
                  '추가하기',
                  style: TextStyle(
                    color: PKBAppState().secondaryColor,
                    fontSize: backIconSize,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),),),),
              const SizedBox(height: 20),
              Expanded(
                child: PKBAppState().userAllergies.isNotEmpty
                    ? ListView.builder(
                        itemCount: PKBAppState().userAllergies.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent, // Transparent background
                                border: Border.all(color: PKBAppState().secondaryColor, width: 1.0), // White border
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            child: Row(
                              children: [
                                Expanded(
                                  // Wrap Text in Expanded to ensure it takes up remaining space
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0), // Padding around the Text
                                    child: Text(
                                    PKBAppState().userAllergies[index],
                                    style: TextStyle(
                                      color: PKBAppState().secondaryColor,
                                    ),
                                  ),),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: PKBAppState().secondaryColor, // Background color
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Semantics(
                                    label: '삭제',
                                    container: true,
                                    child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        PKBAppState().userAllergies.removeAt(index);
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0), // Padding around the SVG
                                      child: SvgPicture.asset(
                                        'assets/images/trash.svg', // Path to the SVG asset
                                        height: 38,
                                        colorFilter: ColorFilter.mode(
                                          PKBAppState().tertiaryColor, // SVG color
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),),
                                ),
                              ],
                            ),
                    );
                  },
                )
                    : Container()
              ),
              ],
          ),
        ),
      ),
    );
  }
}