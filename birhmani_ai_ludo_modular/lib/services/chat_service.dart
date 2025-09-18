import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatService {
  final bool useGemini;
  final String apiKey;
  ChatService._(this.useGemini, this.apiKey);
  static ChatService create() {
    final use = (dotenv.env['USE_GEMINI'] ?? 'false').toLowerCase()=='true';
    final key = dotenv.env['GEMINI_API_KEY'] ?? '';
    return ChatService._(use, key);
  }

  Future<String> ask(String q) async {
    if (!useGemini || apiKey.isEmpty) return _local(q);
    try {
      final url = Uri.parse('https://api.generativeai.google/v1beta2/models/text-bison-001:predict');
      final body = jsonEncode({'prompt': {'text': q}, 'temperature':0.2,'maxOutputTokens':256});
      final resp = await http.post(url, headers: {'Content-Type':'application/json','Authorization':'Bearer \$apiKey'}, body: body).timeout(Duration(seconds:10));
      if (resp.statusCode==200) {
        final map = jsonDecode(resp.body);
        if (map['predictions']!=null && map['predictions'].isNotEmpty) return map['predictions'][0]['content'] ?? map['predictions'][0]['text'] ?? '';
        if (map['output']!=null && map['output']['text']!=null) return map['output']['text'];
        return 'Gemini response parse error';
      } else return 'Gemini error \${resp.statusCode}';
    } catch (e) { return 'Gemini failed: \$e'; }
  }

  String _local(String q) {
    q = q.toLowerCase();
    if (q.contains('rule')) return 'You need a 6 to enter. Capture sends home. Stars are safe.';
    if (q.contains('strategy')) return 'Prioritize captures and safe squares.';
    return 'Ask me about rules, strategy, or the AI.';
  }
}
