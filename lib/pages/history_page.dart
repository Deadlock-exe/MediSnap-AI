import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("History"),
        backgroundColor: primaryColor,
      ),
    );
  }
}
