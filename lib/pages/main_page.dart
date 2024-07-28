import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:medisnap/components/drawer.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/pages/chat_page.dart';
import 'package:medisnap/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    ChatPage(
      openCameraOnStart: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          left: 50,
          right: 50,
        ),
        child: GNav(
          backgroundColor: primaryColor,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          selectedIndex: _selectedIndex,
          onTabChange: navigateBottomBar,
          color: textColor,
          activeColor: primaryColor,
          tabBackgroundColor: secondaryColor,
          gap: 5,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          tabs: const [
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
        toolbarHeight: 50,
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
      ),
      body: _pages[_selectedIndex],
    );
  }
}
