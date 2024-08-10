import 'package:flutter/material.dart';

class ErrorSnackBar extends StatelessWidget {
  final String message;
  const ErrorSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
  }
}
