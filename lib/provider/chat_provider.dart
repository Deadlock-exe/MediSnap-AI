import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive/hive.dart';
import 'package:medisnap/api/model.dart';

class MyChatProvider with ChangeNotifier {
  ChatSession? _chat;
  bool _isChatInitialized = false;
  final List<String> _messages = [];
  Box<dynamic> _chatBox = Hive.box('chat_sessions');
  List<String> _sessionOrder = [];

  late GenerativeModel model = aiModel;

  List<String> get messages => _messages;
  bool get isChatInitialized => _isChatInitialized;

  MyChatProvider() {
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    _chat = await startChat(model);
    _isChatInitialized = true;
    _messages.add('Bot: Hello! How can I assist you today?');
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    _messages.add('You: $message');
    notifyListeners();
    try {
      final response = await _chat!.sendMessage(Content.text(message));
      _messages.add('Bot: ${response.text ?? "can\'t generate anything"}');
    } catch (e) {
      _messages.add('Bot: Error sending message: $e');
      print('Error details: $e');
    }
    notifyListeners();
  }

  Future<void> sendImage(File image, String prompt) async {
    _messages.add("You: $prompt \n (you added 1 attachment)");
    notifyListeners();
    try {
      final imageBytes = image.readAsBytesSync();
      final promptContent = TextPart(prompt);
      final imagePart = DataPart('image/jpeg', imageBytes);

      final response = await model.generateContent([
        Content.multi([promptContent, imagePart])
      ]);

      _messages.add(
        'Bot: ${response.text ?? 'No response'}',
      );
    } catch (e) {
      _messages.add('Bot: Error analyzing image: $e');
      print('Error details: $e');
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

  void loadSessionOrder() {
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
