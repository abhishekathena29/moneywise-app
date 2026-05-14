import 'dart:convert';

import 'package:http/http.dart' as http;

/// Replace this placeholder with your real Gemini API key when wiring the app
/// for production. The key is read once at startup, so a hot restart is
/// required after changing it.
const String kGeminiApiKey = 'YOUR_GEMINI_API_KEY';

const String _model = 'gemini-1.5-flash-latest';

const String _systemPrompt = '''
You are MoneyWise AI, a friendly financial-literacy tutor for kids and teens
aged 8 to 16. Always:
- Use simple, age-appropriate language and concrete examples (school snacks,
  pocket money, saving for a bike, gift money, etc.).
- Be encouraging, never preachy. Treat the learner with respect.
- Keep answers short (under 120 words unless the user asks for more).
- Refuse to give specific investment advice. Promote saving, budgeting,
  needs-vs-wants thinking, and asking a trusted adult for big decisions.
- Use Indian rupees (₹) by default when giving money examples.
''';

class ChatMessage {
  ChatMessage({
    required this.role,
    required this.text,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  final String role; // 'user' or 'model'
  final String text;
  final DateTime timestamp;
}

class GeminiService {
  GeminiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  bool get hasApiKey =>
      kGeminiApiKey.isNotEmpty && kGeminiApiKey != 'YOUR_GEMINI_API_KEY';

  Future<String> sendMessage(List<ChatMessage> history) async {
    if (!hasApiKey) {
      throw const GeminiException(
        'Gemini API key is not configured. Replace YOUR_GEMINI_API_KEY in '
        'lib/features/chatbot/data/gemini_service.dart.',
      );
    }

    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent?key=$kGeminiApiKey',
    );

    final contents = history
        .map((m) => {
              'role': m.role,
              'parts': [
                {'text': m.text}
              ],
            })
        .toList();

    final body = {
      'systemInstruction': {
        'parts': [
          {'text': _systemPrompt}
        ],
      },
      'contents': contents,
      'generationConfig': {
        'temperature': 0.7,
        'maxOutputTokens': 512,
      },
    };

    final response = await _client.post(
      uri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw GeminiException(
        'Gemini API error ${response.statusCode}: ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = decoded['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw const GeminiException('Gemini returned no response.');
    }
    final parts = (candidates.first
        as Map<String, dynamic>)['content']?['parts'] as List?;
    if (parts == null || parts.isEmpty) {
      throw const GeminiException('Gemini returned an empty answer.');
    }
    return (parts.first as Map<String, dynamic>)['text']?.toString() ?? '';
  }
}

class GeminiException implements Exception {
  const GeminiException(this.message);
  final String message;

  @override
  String toString() => message;
}
