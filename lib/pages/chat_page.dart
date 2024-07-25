import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisnap/api/model.dart';
import 'package:medisnap/components/chat_model.dart';
import 'package:medisnap/components/image/send_image.dart';
import 'package:medisnap/constants/colors.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  bool openCameraOnStart;
  ChatPage({
    super.key,
    required this.openCameraOnStart,
  });

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
    Gemini.init(apiKey: apiKey);
    if (widget.openCameraOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pickImage(ImageSource.camera, context, _sendImage);
      });
    }
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

  Future<void> _sendImage(File image, String prompt) async {
    setState(() {
      _messages.add("You: $prompt \n (you added 1 attachment)");
    });
    try {
      final gemini = Gemini.instance;
      final response = await gemini.textAndImage(
        text: prompt,
        images: [image.readAsBytesSync()],
      );
      setState(() {
        _messages.add(
            'Bot: ${response?.content?.parts?.last.text ?? 'No response'}');
      });
    } catch (e) {
      setState(() {
        _messages.add('Bot: Error analyzing image: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: primaryColor,
      ),
      body: ChatModel(
        messages: _messages,
        controller: _controller,
        sendMessage: _sendMessage,
        sendImage: _sendImage,
      ),
    );
  }
}
