import 'package:flutter/material.dart';
import 'package:medisnap/components/camera_button.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/provider/nav_provider.dart';
import 'package:medisnap/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      floatingActionButton: CameraButton(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
            child: Image.asset('assets/images/home.png'),
          ),
          Text(
            "Welcome! ${Provider.of<UserProvider>(context).displayName}",
            style: TextStyle(
              fontSize: 25,
              color: textColor,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: MaterialButton(
                color: accentColor,
                height: 45,
                minWidth: 270,
                child: Text(
                  "Discover the MediSnap AI",
                  style: TextStyle(fontSize: 17, color: primaryColor),
                ),
                onPressed: () {
                  Provider.of<NavProvider>(
                    context,
                    listen: false,
                  ).toChatPage(false);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: MaterialButton(
                color: textColor,
                height: 45,
                minWidth: 270,
                child: Text(
                  "Commuity COMING SOON",
                  style: TextStyle(fontSize: 17, color: primaryColor),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
