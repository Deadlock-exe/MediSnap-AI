import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 120,
                  color: secondaryColor,
                ),
              ),
            ),
            ListTile(
              titleTextStyle: TextStyle(
                color: textColor,
              ),
              leading: Icon(
                Icons.settings,
                color: textColor,
              ),
              title: Text("Edit profile"),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const MainPage(),
                //   ),
                // );
              },
            ),
            ListTile(
              titleTextStyle: TextStyle(
                color: textColor,
              ),
              leading: Icon(
                Icons.logout,
                color: textColor,
              ),
              title: Text("Logout"),
              onTap: () {
                Provider.of<FirebaseAuthProvider>(listen: false, context)
                    .signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
