import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decoration_plants_store/pages/profile/for_profile/fire_store_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetDataFromFirebase extends StatefulWidget {
  final String documentId;
  const GetDataFromFirebase({super.key, required this.documentId});

  @override
  State<GetDataFromFirebase> createState() => _GetDataFromFirebaseState();
}

class _GetDataFromFirebaseState extends State<GetDataFromFirebase> {
  final dialogUsernameController = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('my users');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text("Something went wrong", style: TextStyle(fontSize: 18,),),);
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text("Document does not exist", style: TextStyle(fontSize: 18,),),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FireStoreRow(
                text: "Username: ${data['username'] ?? 'not exist'}",
                myDialog: myDialog(data, 'username'),
                deleteField: deleteField('username'),
              ),
              FireStoreRow(
                text: "Email: ${data['email'] ?? 'not exist'}",
                myDialog: myDialog(data, 'email'),
                deleteField: deleteField('email'),
              ),
              FireStoreRow(
                text: "Password: ${data['password'] ?? 'not exist'}",
                myDialog: myDialog(data, 'password'),
                deleteField: deleteField('password'),
              ),
              FireStoreRow(
                text: "Age: ${data['age'] ?? 'not exist'} years old",
                myDialog: myDialog(data, 'age'),
                deleteField: deleteField('age'),
              ),
              FireStoreRow(
                text: "Title: ${data['title'] ?? 'not exist'} ",
                myDialog: myDialog(data, 'title'),
                deleteField: deleteField('title'),
              ),

              Center(
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        users.doc(credential!.uid).delete();
                      });
                    },
                    child: const Text(
                      "Delete Data",
                      style: TextStyle(fontSize: 24),
                    ),
                ),
              ),
            ],
          );
        }
        return const Text("loading");
      },
    );
  }

  deleteField(dynamic myKey){
    setState(() {
      users
          .doc(credential!.uid)
          .update({myKey: FieldValue.delete()});
    });
  }

  myDialog(Map data, dynamic myKey) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: const EdgeInsets.all(24),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: dialogUsernameController,
                    maxLength: 20,
                    decoration:
                    InputDecoration(hintText: "${data[myKey]}"),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          users
                              .doc(credential!.uid)
                              .update({myKey: dialogUsernameController.text});

                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 18),
                        ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 18),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}