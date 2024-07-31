import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/provider/image_provider.dart';
import 'package:provider/provider.dart';

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
              final color = isUserMessage ? secondaryColor : accentColor;
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
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
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
                      style: TextStyle(fontSize: 15),
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
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: textColor,
                ),
                onPressed: () {
                  context
                      .read<MyImageProvider>()
                      .pickImage(ImageSource.camera, context, sendImage);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.photo_album,
                  color: textColor,
                ),
                onPressed: () {
                  context
                      .read<MyImageProvider>()
                      .pickImage(ImageSource.gallery, context, sendImage);
                },
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(color: textColor),
                  controller: controller,
                  autocorrect: false,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: TextStyle(color: secondaryColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                        width: 1,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 14,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: accentColor,
                  size: 30,
                ),
                onPressed: () {
                  final message = controller.text;
                  if (message.isNotEmpty) {
                    sendMessage(message);
                  }
                  controller.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
