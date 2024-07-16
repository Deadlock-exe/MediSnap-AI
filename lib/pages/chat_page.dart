import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:medisnap/api/model.dart';
import 'package:medisnap/components/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatSession _chat;
  // ignore: unused_field
  bool _isChatInitialized = false;
  List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    final model = aiModel;
    _chat = await startChat(model);
    setState(() {
      _isChatInitialized = true;
      if (_messages.isEmpty) {
        _messages.add('Bot: Hello! How can I assist you today?');
      }
    });
  }

  Future<void> _sendMessage(String message) async {
    _controller.clear();
    setState(() {
      _messages.add('You: $message');
    });
    final response = await sendMessage(_chat, message);
    setState(() {
      _messages.add('Bot: $response');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI CHAT"),
      ),
      body: ChatModel(
        messages: _messages,
        controller: _controller,
        sendMessage: _sendMessage,
      ),
    );
  }
}
