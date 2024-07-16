import 'package:flutter/material.dart';
import 'package:medisnap/auth/login_page.dart';
import 'package:medisnap/auth/signup_page.dart';
import 'package:medisnap/pages/chat_page.dart';
import 'package:medisnap/pages/home_page.dart';
import 'package:medisnap/pages/main_page.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/login': (context) => LoginPage(),
  '/signup': (context) => SignupPage(),
  '/main': (context) => MainPage(),
  '/home': (context) => HomePage(),
  '/chat': (context) => ChatPage(),
};
