import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  Future<bool> init() async => await _speech.initialize();
  Future<String?> listen() async {
    if (!await _speech.initialize()) return null;
    String result='';
    await _speech.listen(onResult: (r){ result = r.recognizedWords; }, listenFor: Duration(seconds:5));
    await Future.delayed(Duration(seconds:5));
    await _speech.stop();
    return result;
  }
  Future speak(String text) async => await _tts.speak(text);
  void dispose(){ _tts.stop(); }
}
