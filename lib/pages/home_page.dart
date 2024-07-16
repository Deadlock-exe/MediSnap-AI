import 'package:flutter/material.dart';
import 'package:medisnap/components/camera_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
      ),
      floatingActionButton: CameraButton(),
    );
  }
}
