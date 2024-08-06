import 'package:flutter/material.dart';
import 'package:medisnap/components/intro_container.dart';
import 'package:medisnap/components/smooth_dots.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onLastPage = (value == 2);
              });
            },
            children: [
              IntroContainer(),
              IntroContainer(),
              IntroContainer(),
            ],
          ),
          SmoothDots(
            onLastPage: onLastPage,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
