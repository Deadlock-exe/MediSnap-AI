import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medisnap/components/profile_photo.dart';
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
      appBar: AppBar(
        title: Text('Enter Display Name'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfilePhoto(pfpSize: 40),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  await userProvider.updateProfilePhoto(image.path);
                }
              },
              child: Text('Update Profile Photo'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _displayNameController,
              decoration: InputDecoration(labelText: 'Display Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String displayName = _displayNameController.text;
                Provider.of<UserProvider>(context, listen: false)
                    .updateDisplayName(displayName);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
