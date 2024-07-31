import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _displayName;
  String? _profilePhotoPath;

  String? get displayName => _displayName;
  String? get profilePhotoPath => _profilePhotoPath;

  UserProvider() {
    _loadUserData();
  }

  Future<void> initializeUserDocument() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentReference userDocRef =
          _firestore.collection('users').doc(user.uid);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        await userDocRef.set({
          'displayName': 'New User',
        });
      }
    }
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        _displayName = userDoc['displayName'];

        // Load profile photo from Hive
        var box = await Hive.openBox('user_data');
        _profilePhotoPath = box.get('profilePhotoPath');
      } else {
        _displayName = null;
        _profilePhotoPath = null;
      }
      notifyListeners();
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'displayName': displayName});
      _displayName = displayName;
      notifyListeners();
    }
  }

  Future<void> updateProfilePhoto(String profilePhotoPath) async {
    try {
      // Save profile photo path to Hive
      var box = await Hive.openBox('user_data');
      await box.put('profilePhotoPath', profilePhotoPath);

      // Update local state
      _profilePhotoPath = profilePhotoPath;
      notifyListeners();
    } catch (e) {
      print('Error updating profile photo: $e');
      // Handle error gracefully
    }
  }
}
