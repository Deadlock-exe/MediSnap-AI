import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:medisnap/components/drawer.dart';
import 'package:medisnap/components/profile_photo.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/pages/chat_page.dart';
import 'package:medisnap/pages/history_page.dart';
import 'package:medisnap/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:medisnap/provider/nav_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    final List<Widget> _pages = [
      const HistoryPage(),
      const HomePage(),
      ChatPage(
        openCameraOnStart: navProvider.openCameraOnChatPageStart,
      ),
    ];

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          left: 25,
          right: 25,
        ),
        child: GNav(
          backgroundColor: primaryColor,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          selectedIndex: navProvider.selectedIndex,
          onTabChange: (index) {
            navProvider.setSelectedIndex(index, false);
          },
          color: textColor,
          activeColor: primaryColor,
          tabBackgroundColor: secondaryColor,
          gap: 5,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          tabs: const [
            GButton(
              icon: Icons.history,
              text: "HISTORY",
              iconSize: 25,
            ),
            GButton(
              icon: Icons.home_sharp,
              text: "HOME",
              iconSize: 25,
            ),
            GButton(
              icon: Icons.chat,
              text: "CHAT",
              iconSize: 25,
            ),
          ],
        ),
      ),
      backgroundColor: primaryColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: primaryColor,
        toolbarHeight: 55,
        centerTitle: true,
        title: const Text(
          "MediSnap",
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 9,
            ),
            child: ProfilePhoto(
              pfpSize: 20,
            ),
          ),
        ],
      ),
      body: _pages[navProvider.selectedIndex],
    );
  }
}
