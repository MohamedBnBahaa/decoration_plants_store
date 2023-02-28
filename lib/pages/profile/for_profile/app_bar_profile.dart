import 'package:decoration_plants_store/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppBarProfile extends StatelessWidget {
  const AppBarProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        TextButton.icon(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          label: const Text(
            "logout",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        )
      ],
      backgroundColor: appbarGreen,
      title: const Text("Profile Page"),
    );
  }
}
