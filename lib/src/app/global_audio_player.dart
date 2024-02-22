import 'package:audioplayers/audioplayers.dart';

class GlobalAudioPlayer {
  static final GlobalAudioPlayer _instance = GlobalAudioPlayer._internal();
  final AudioPlayer audioPlayer;
  bool _isLooping = false;

  factory GlobalAudioPlayer() {
    return _instance;
  }

  GlobalAudioPlayer._internal() : audioPlayer = AudioPlayer();

  // Play audio on repeat
  Future<void> playRepeat() async {
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.play(AssetSource('audios/piep-33489.mp3'));
  }

  // Play audio one time
  Future<void> playOnce() async {
    await audioPlayer.setReleaseMode(ReleaseMode.release);
    await audioPlayer.play(AssetSource('audios/success.mp3'));
  }

  // Play audio on repeat with controllable rate
  Future<void> playRepeatWithRate(double rate) async {
    await audioPlayer.setPlaybackRate(rate);
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.play(AssetSource('audios/piep-33489.mp3'));
  }

  Future<void> changeRateForRepeat(double rate) async {
    if (_isLooping) {
      await audioPlayer.setPlaybackRate(rate);
    } else {
      await playRepeatWithRate(rate);
    }
  }

  void pause() {
    audioPlayer.pause();
  }

  void stop() {
    audioPlayer.stop();
    audioPlayer.release();
  }
  void resume() {
    audioPlayer.resume();
  }

  bool get isPlaying => audioPlayer.state == PlayerState.playing;
}