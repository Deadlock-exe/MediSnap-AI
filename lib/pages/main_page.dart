import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 30,
        ),
        child: GNav(
          selectedIndex: _selectedIndex,
          onTabChange: navigateBottomBar,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.black,
          gap: 8,
          padding: const EdgeInsets.all(20),
          tabs: const [
            GButton(
              icon: Icons.home_sharp,
              text: "HOME",
            ),
            GButton(
              icon: Icons.chat,
              text: "CHAT",
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        title: const Text(
          "MediSnap",
          style: TextStyle(
            letterSpacing: 3,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
