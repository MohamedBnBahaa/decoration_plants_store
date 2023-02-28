import 'package:decoration_plants_store/pages/profile/for_profile/app_bar_profile.dart';
import 'package:decoration_plants_store/pages/profile/for_profile/auth_data.dart';
import 'package:decoration_plants_store/pages/profile/for_profile/data_from_firebase.dart';
import 'package:decoration_plants_store/pages/profile/for_profile/from_where.dart';
import 'package:decoration_plants_store/pages/profile/for_profile/profile_photo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final credential = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarProfile(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfilePhoto(),

              const SizedBox(height: 32,),

              const FromWhere(fromWhereText: "Info from firebase Auth",),

              AuthData(),

              const SizedBox(height: 40,),

              const FromWhere(fromWhereText: "Info from firebase fire store",),

              GetDataFromFirebase(documentId: credential?.uid as String,),
            ],
          ),
        ),
      ),
    );
  }
}