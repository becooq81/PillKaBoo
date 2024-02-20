import '../../../../../../core/pillkaboo_theme.dart';
import '../../../../../core/pillkaboo_util.dart';
import '../../../../widgets/index.dart' as widgets;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'allergy_add_page_model.dart';
export 'allergy_add_page_model.dart';


class AllergyAddPageWidget extends StatefulWidget {
  const AllergyAddPageWidget({super.key});

  @override
  State<AllergyAddPageWidget> createState() => _AllergyAddPageWidgetState();
}

class _AllergyAddPageWidgetState extends State<AllergyAddPageWidget> {
  late AllergyAddPageModel _model;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllergyAddPageModel());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
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

    double appBarFontSize = 32.0/892.0 * MediaQuery.of(context).size.height;
    double backIconSize = 30.0/892.0 * MediaQuery.of(context).size.height;

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
            label: '알러지 성분 추가',
            child: ExcludeSemantics(
              excluding: true,
              child: Text(
                '알러지 성분 추가',
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: '알레르기 성분을 입력해주세요',
                  filled: true,
                  fillColor: PKBAppState().secondaryColor, // Background color
                  contentPadding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0), // Adjusts height by increasing inner padding
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // Hides the border to emphasize the background color
                    borderRadius: BorderRadius.circular(10.0), // Optional: Adds rounded corners
                  ),
                ),
                style: TextStyle(
                  color: PKBAppState().tertiaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pretendard',
                ),
                autofocus: true,
              ),),),
              const SizedBox(height: 10), // Add some space between the text field and the button
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(PKBAppState().tertiaryColor), // Background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.0),
                        side: BorderSide(color: PKBAppState().secondaryColor), // Border color
                      ),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      PKBAppState().addToUserAllergies(_controller.text);
                    });
                    context.go('/allergyListPage');
                  },
                  child: Text('확인',
                      style: TextStyle(
                        color: PKBAppState().secondaryColor,
                        fontSize: backIconSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}