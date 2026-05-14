import 'package:flutter/material.dart';

import '../data/gemini_service.dart';

class ChatbotProvider extends ChangeNotifier {
  ChatbotProvider({GeminiService? service})
      : _service = service ?? GeminiService();

  final GeminiService _service;
  final List<ChatMessage> _messages = [
    ChatMessage(
      role: 'model',
      text:
          "Hi! I'm MoneyWise AI 👋 Ask me anything about money — saving, "
          "budgeting, smart spending, or your goals.",
    ),
  ];

  bool _sending = false;
  String? _error;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isSending => _sending;
  bool get hasApiKey => _service.hasApiKey;
  String? get error => _error;

  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _sending) return;
    _error = null;
    _messages.add(ChatMessage(role: 'user', text: trimmed));
    _sending = true;
    notifyListeners();
    try {
      final reply = await _service.sendMessage(_messages);
      _messages.add(ChatMessage(role: 'model', text: reply));
    } on GeminiException catch (e) {
      _error = e.message;
      _messages.add(ChatMessage(
        role: 'model',
        text:
            "I can't reach the AI service right now. Please try again later.",
      ));
    } catch (_) {
      _error = 'Something went wrong. Please try again.';
      _messages.add(ChatMessage(
        role: 'model',
        text: "Hmm, something went wrong. Please try again in a moment.",
      ));
    } finally {
      _sending = false;
      notifyListeners();
    }
  }

  void clear() {
    _messages.removeRange(1, _messages.length);
    _error = null;
    notifyListeners();
  }
}
