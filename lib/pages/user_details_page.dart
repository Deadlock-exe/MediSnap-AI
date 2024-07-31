import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisnap/components/profile_photo.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:medisnap/provider/user_provider.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late TextEditingController _displayNameController;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _displayNameController =
        TextEditingController(text: userProvider.displayName ?? '');
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: secondaryColor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: [
            ProfilePhoto(pfpSize: 50),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  await userProvider.updateProfilePhoto(image.path);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
              ),
              child: const Text(
                "Select Photo",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              child: TextField(
                controller: _displayNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Display Name',
                  labelStyle: TextStyle(color: secondaryColor),
                ),
                style: TextStyle(color: textColor),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                String displayName = _displayNameController.text;
                Provider.of<UserProvider>(context, listen: false)
                    .updateDisplayName(displayName);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 30,
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
