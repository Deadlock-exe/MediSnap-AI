import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisnap/constants/colors.dart';

class MyImageProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source, BuildContext context,
      Function(File, String) sendImage) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      showPromptDialog(context, image, sendImage);
    }
  }

  Future<void> showPromptDialog(BuildContext context, File image,
      Function(File, String) sendImage) async {
    String prompt = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title: const Text(
            'Enter a prompt for the image',
            style: TextStyle(color: textColor),
          ),
          content: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.3,
                    ),
                    child: Image.file(image),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    autocorrect: false,
                    onChanged: (value) {
                      prompt = value;
                    },
                    style: TextStyle(color: textColor),
                    decoration: const InputDecoration(
                      hintText: "Enter prompt here",
                      hintStyle: TextStyle(color: secondaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: primaryColor,
              ),
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
}
