import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/provider/auth_provider.dart';
import 'package:medisnap/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    String? userName = userProvider.displayName ?? "unKnown";
    String? profilePhotoUrl = userProvider.profilePhotoUrl;

    return Drawer(
      backgroundColor: primaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (profilePhotoUrl != null)
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(profilePhotoUrl),
                    )
                  else
                    Icon(
                      Icons.person,
                      size: 40,
                      color: secondaryColor,
                    ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      "Hello! $userName",
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
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
              Navigator.pushNamed(context, '/user');
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
              Provider.of<FirebaseAuthProvider>(context, listen: false)
                  .signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
