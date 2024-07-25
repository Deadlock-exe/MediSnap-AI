import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/pages/chat_page.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: accentColor,
      foregroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 1,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatPage(openCameraOnStart: true),
        ));
      },
      child: Icon(
        Icons.camera_alt,
        size: 30,
      ),
    );
  }
}
