import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:medisnap/components/drawer.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          selectedIndex: _selectedIndex,
          onTabChange: navigateBottomBar,
          color: Colors.grey,
          activeColor: Colors.blue,
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
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
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
