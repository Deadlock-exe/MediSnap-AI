import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  int _selectedIndex = 1;
  bool _openCameraOnChatPageStart = false;

  int get selectedIndex => _selectedIndex;
  bool get openCameraOnChatPageStart => _openCameraOnChatPageStart;

  void toHomePage() {
    _selectedIndex = 1;
    notifyListeners();
  }

  void toChatPage(bool openCamera) {
    _selectedIndex = 2;
    _openCameraOnChatPageStart = openCamera;
    notifyListeners();
  }

  void toHistoryPage() {
    _selectedIndex = 0;
    notifyListeners();
  }

  void setSelectedIndex(int index, bool openCamera) {
    _selectedIndex = index;
    if (index == 2) {
      _openCameraOnChatPageStart = openCamera;
    } else {
      _openCameraOnChatPageStart = false;
    }
    notifyListeners();
  }
}
