import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisnap/components/chat_model.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/provider/chat_provider.dart';
import 'package:medisnap/provider/image_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  bool openCameraOnStart = false;
  ChatPage({
    super.key,
    required this.openCameraOnStart,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.openCameraOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MyImageProvider>().pickImage(
          ImageSource.camera,
          context,
          (image, prompt) {
            context.read<MyChatProvider>().sendImage(image, prompt);
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<MyChatProvider>();

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_alt,
              size: 25,
              color: textColor,
            ),
            onPressed: () {
              chatProvider.saveSession();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Chat session saved!')),
              );
            },
          ),
        ],
      ),
      body: ChatModel(
        messages: chatProvider.messages,
        controller: _controller,
        sendMessage: (message) {
          chatProvider.sendMessage(message);
        },
        sendImage: (image, prompt) {
          chatProvider.sendImage(image, prompt);
        },
      ),
    );
  }
}
