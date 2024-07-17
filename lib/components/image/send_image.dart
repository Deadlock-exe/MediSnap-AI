import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> pickImage(ImageSource source, BuildContext context,
    Function(File, String) sendImage) async {
  final pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile != null) {
    final image = File(pickedFile.path);
    showPromptDialog(context, image, sendImage);
  }
}

Future<void> showPromptDialog(
    BuildContext context, File image, Function(File, String) sendImage) async {
  String prompt = '';
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter a prompt for the image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: Image.file(image),
            ),
            TextField(
              onChanged: (value) {
                prompt = value;
              },
              decoration: const InputDecoration(hintText: "Enter prompt here"),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('SEND'),
            onPressed: () {
              Navigator.of(context).pop();
              sendImage(image, prompt);
            },
          ),
        ],
      );
    },
  );
}
