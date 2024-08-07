import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';

class IntroContainer extends StatelessWidget {
  final String imagePath;
  final String pageText;
  const IntroContainer({
    super.key,
    required this.imagePath,
    required this.pageText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            child: Image.asset(
              imagePath,
              width: 160,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            child: Text(
              pageText,
              style: TextStyle(color: accentColor, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
