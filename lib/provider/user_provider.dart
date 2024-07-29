import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String? _displayName;
  String? _profilePhotoUrl;

  String? get displayName => _displayName;
  String? get profilePhotoUrl => _profilePhotoUrl;

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
          'profilePhotoUrl': '',
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
        _profilePhotoUrl = userDoc['profilePhotoUrl'];
      } else {
        _displayName = null;
        _profilePhotoUrl = null;
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

  Future<void> uploadProfilePhoto(File file) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        if (!await file.exists()) {
          print('File does not exist: ${file.path}');
          return;
        }

        // Define the storage reference
        Reference storageRef =
            _storage.ref().child('user_profile_photos').child(user.uid);

        // Upload the file
        UploadTask uploadTask = storageRef.putFile(file);

        // Wait for the upload to complete
        TaskSnapshot snapshot = await uploadTask;

        // Check if the upload was successful
        if (snapshot.state == TaskState.success) {
          // Get the download URL
          String downloadUrl = await snapshot.ref.getDownloadURL();

          // Update Firestore with the new URL
          await _firestore
              .collection('users')
              .doc(user.uid)
              .update({'profilePhotoUrl': downloadUrl});

          // Update local state
          _profilePhotoUrl = downloadUrl;
          notifyListeners();
        } else {
          print('Upload failed');
        }
      } catch (e) {
        print('Error uploading profile photo: $e');
        // Handle error gracefully
      }
    }
  }

  Future<void> updateProfilePhoto(String profilePhotoPath) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // First, update Firestore with the placeholder or initial path
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update({'profilePhotoUrl': profilePhotoPath});

        // Immediately update local state with the new profile photo path
        _profilePhotoUrl = profilePhotoPath;
        notifyListeners();

        // Now perform the actual upload in the background
        File file = File(profilePhotoPath);
        await uploadProfilePhoto(file);
      } catch (e) {
        print('Error updating profile photo path: $e');
        // Optionally revert the placeholder URL or handle error
      }
    }
  }
}
