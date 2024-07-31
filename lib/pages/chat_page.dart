import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisnap/components/chat_model.dart';
import 'package:medisnap/components/save_dialog.dart';
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
        title: Text(
          "Chat with AI",
          style: TextStyle(
            color: secondaryColor,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 40,
        backgroundColor: primaryColor,
        actions: [
          PopupMenuButton<String>(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.more_vert_outlined,
                size: 25,
                color: textColor,
              ),
            ),
            onSelected: (String value) async {
              if (value == 'save') {
                final sessionName = await showSaveDialog(context);
                if (sessionName != null && sessionName.isNotEmpty) {
                  chatProvider.saveSession(sessionName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Chat session "$sessionName" saved!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } else if (value == 'new') {
                final sessionName = await showSaveDialog(context);
                if (sessionName != null && sessionName.isNotEmpty) {
                  chatProvider.saveSession(sessionName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Chat session "$sessionName" saved!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                chatProvider.clearChat();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'save',
                child: Text('Save Chat'),
              ),
              const PopupMenuItem<String>(
                value: 'new',
                child: Text('New Chat'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ChatModel(
          messages: chatProvider.messages,
          controller: _controller,
          sendMessage: (message) {
            chatProvider.sendMessage(message);
          },
          sendImage: (image, prompt) {
            chatProvider.sendImage(image, prompt);
          },
        ),
      ),
    );
  }
}
