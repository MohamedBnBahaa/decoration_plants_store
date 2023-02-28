import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserEmail extends StatelessWidget {
  UserEmail({Key? key,}) : super(key: key);
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
          return const Text(
              "your email does not exist",
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            "${data["email"]}",
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0),),
          );
        }
        return const Text("loading");
      },
    );
  }
}