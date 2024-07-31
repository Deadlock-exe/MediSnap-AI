import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePhoto extends StatelessWidget {
  final double pfpSize;
  const ProfilePhoto({
    super.key,
    required this.pfpSize,
  });

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    String? pfpPath = userProvider.profilePhotoPath;

    return Container(
      child: (pfpPath != null && pfpPath.isNotEmpty)
          ? CircleAvatar(
              radius: pfpSize,
              backgroundImage: FileImage(File(pfpPath)),
            )
          : Icon(
              Icons.person,
              size: pfpSize,
              color: secondaryColor,
            ),
    );
  }
}
