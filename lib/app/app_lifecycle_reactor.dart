import 'package:flutter/material.dart';
import 'global_audio_player.dart';

class AppLifecycleReactor with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      // App is in the background or terminated, handle resource cleanup.
      GlobalAudioPlayer().stop();
    }
  }
}