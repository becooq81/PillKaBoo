import 'package:flutter/material.dart';
import '../../styles/pillkaboo_icon_button.dart';
import '../../../core/pillkaboo_util.dart';
import '../../../app/global_audio_player.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final double iconSize = 30.0/892.0 * MediaQuery.of(context).size.height;
    final double buttonSize = 60.0/892.0 * MediaQuery.of(context).size.height;

    return Semantics(
        label: '홈으로 가기. 실행하려면 두번 누르세요',
        child: ExcludeSemantics(
          excluding: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
            child: PillKaBooIconButton(
              borderColor: Colors.transparent,
              borderRadius: iconSize,
              borderWidth: 1.0,
              buttonSize: buttonSize,
              icon: Icon(
                Icons.home,
                color: PKBAppState().secondaryColor,
                size: iconSize,
              ),
              onPressed: () {
                if (GlobalAudioPlayer().isPlaying) {
                  GlobalAudioPlayer().pause();
                }
                context.pushNamed('MainMenuPage');
              },
            ),
        ),
      ),
    );
  }
}
