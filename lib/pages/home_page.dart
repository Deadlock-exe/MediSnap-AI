import 'package:flutter/material.dart';
import 'package:medisnap/components/camera_button.dart';
import 'package:medisnap/constants/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      floatingActionButton: CameraButton(),
    );
  }
}
