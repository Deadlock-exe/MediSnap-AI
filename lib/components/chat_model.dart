import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisnap/components/image/send_image.dart';

class ChatModel extends StatelessWidget {
  final List<String> messages;
  final TextEditingController controller;
  final Function(String) sendMessage;
  final Function(File, String) sendImage;

  const ChatModel({
    super.key,
    required this.messages,
    required this.controller,
    required this.sendMessage,
    required this.sendImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: false,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isUserMessage = message.startsWith('You:');
              final alignment =
                  isUserMessage ? Alignment.centerRight : Alignment.centerLeft;
              final color = isUserMessage ? Colors.blue[200] : Colors.grey[300];
              final borderRadius = isUserMessage
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    );

              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Align(
                  alignment: alignment,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: borderRadius,
                    ),
                    child: Text(
                      message.substring(5),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.camera_alt_outlined),
                onPressed: () {
                  pickImage(ImageSource.camera, context, sendImage);
                },
              ),
              IconButton(
                icon: Icon(Icons.photo_album),
                onPressed: () {
                  pickImage(ImageSource.gallery, context, sendImage);
                },
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  autocorrect: false,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  final message = controller.text;
                  if (message.isNotEmpty) {
                    sendMessage(message);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
