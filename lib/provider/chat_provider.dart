import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart' as flutter_gemini;
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive/hive.dart';
import 'package:medisnap/api/model.dart';

class MyChatProvider with ChangeNotifier {
  ChatSession? _chat;
  bool _isChatInitialized = false;
  final List<String> _messages = [];
  Box<dynamic> _chatBox = Hive.box('chat_sessions');
  List<String> _sessionOrder = [];

  List<String> get messages => _messages;
  bool get isChatInitialized => _isChatInitialized;

  MyChatProvider() {
    _initializeChat();
    _loadSessionOrder();
  }

  Future<void> _initializeChat() async {
    final model = aiModel;
    flutter_gemini.Gemini.init(apiKey: apiKey);
    _chat = await startChat(model);
    _isChatInitialized = true;
    _messages.add('Bot: Hello! How can I assist you today?');
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    _messages.add('You: $message');
    notifyListeners();
    final response = await _chat!.sendMessage(Content.text(message));
    _messages.add('Bot: ${response.text ?? "can\'t generate anything"}');
    notifyListeners();
  }

  Future<void> sendImage(File image, String prompt) async {
    _messages.add("You: $prompt \n (you added 1 attachment)");
    notifyListeners();
    try {
      final gemini = flutter_gemini.Gemini.instance;
      final response = await gemini.textAndImage(
        text: prompt,
        images: [image.readAsBytesSync()],
      );
      _messages.add(
        'Bot: ${response?.content?.parts?.last.text ?? 'No response'}',
      );
    } catch (e) {
      _messages.add('Bot: Error analyzing image: $e');
    }
    notifyListeners();
  }

  void saveSession(String sessionName) {
    _chatBox.put(sessionName, _messages.toList());
    _sessionOrder.add(sessionName);
    _chatBox.put('session_order', _sessionOrder);
  }

  void loadSession(List<String> messages) {
    _messages.clear();
    _messages.addAll(messages);
    notifyListeners();
  }

  void _loadSessionOrder() {
    if (_chatBox.containsKey('session_order')) {
      _sessionOrder = _chatBox.get('session_order').cast<String>();
    }
  }

  List<String> getAllSessions() {
    return _sessionOrder.reversed.toList();
  }

  List<String> getSession(String key) {
    return _chatBox.get(key).cast<String>();
  }

  void clearChat() {
    _messages.clear();
    _initializeChat();
    notifyListeners();
  }

  void clearAllSessions() {
    _chatBox.clear();
    _sessionOrder.clear();
    notifyListeners();
  }
}
