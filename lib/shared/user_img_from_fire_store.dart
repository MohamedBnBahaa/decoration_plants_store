import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserImg extends StatelessWidget {
  UserImg({Key? key,}) : super(key: key);
  final credential = FirebaseAuth.instance.currentUser;
  final CollectionReference users = FirebaseFirestore.instance.collection('my users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential?.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const CircleAvatar(
            radius: 72,
            backgroundImage: AssetImage("assets/images/boy_avatar.jpg",),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data?.data() as Map<String, dynamic>;
          return CircleAvatar(
            // backgroundColor: const Color.fromARGB(255, 225, 225, 225),
            radius: 72,
            backgroundImage: NetworkImage(data["imgLink"]),
          );
        }
        return const Text("loading");
      },
    );
  }
}