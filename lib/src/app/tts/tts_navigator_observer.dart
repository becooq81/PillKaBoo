import 'package:flutter/material.dart';
import 'tts_service.dart';

class TtsNavigatorObserver extends NavigatorObserver {
  final TtsService ttsService;

  TtsNavigatorObserver({required this.ttsService});

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    ttsService.stop();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    ttsService.stop();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    ttsService.stop();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    ttsService.stop();
  }
}
