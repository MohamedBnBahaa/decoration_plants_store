import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decoration_plants_store/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuthData extends StatelessWidget {
  AuthData({Key? key}) : super(key: key);
  final CollectionReference users = FirebaseFirestore.instance.collection('my users');
  final credential = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12,),
        Text(
          "Email:  ${credential?.email}",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12,),
        Text(
          "Created date:  ${DateFormat("MMMM d, y").format(credential?.metadata.creationTime as DateTime)}",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12,),
        Text(
          "Last Signed In:  ${DateFormat("MMMM d, y").format(credential?.metadata.lastSignInTime as DateTime)}",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 16,),

        Center(
          child: TextButton(
              onPressed: () {
                credential!.delete();
                Navigator.pop(context);
              },
              child: const Text(
                "Delete User",
                style: TextStyle(fontSize: 22, color: btnPink,),
              )),
        ),
      ],
    );
  }
}
