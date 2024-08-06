import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothDots extends StatelessWidget {
  final bool onLastPage;
  final PageController controller;
  const SmoothDots({
    super.key,
    required this.onLastPage,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0.75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          onLastPage
              ? GestureDetector(
                  onTap: () {
                    controller.jumpToPage(2);
                  },
                  child: SizedBox(
                    width: 40,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: SizedBox(
                    width: 40,
                    child: Text(
                      "Skip",
                      style: TextStyle(color: textColor),
                    ),
                  ),
                ),
          SmoothPageIndicator(controller: controller, count: 3),
          onLastPage
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/main');
                  },
                  child: SizedBox(
                    width: 40,
                    child: Text(
                      "Done",
                      style: TextStyle(color: textColor),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: SizedBox(
                    width: 40,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: textColor,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
