import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decoration_plants_store/shared/show_snack_bar.dart';
import 'package:decoration_plants_store/shared/user_img_from_fire_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({Key? key}) : super(key: key);

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  CollectionReference users = FirebaseFirestore.instance.collection('my users');
  final credential = FirebaseAuth.instance.currentUser;
  File? imgPath;
  String? imgName;

  uploadImage2Screen(ImageSource source) async {
    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        if (mounted) {
          showSnackBar(context, "NO img selected.");
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, "Error => $e");
      }
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  chooseGalleryOrCamera() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.camera,
                      size: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () async {
                  await  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.photo_outlined,
                      size: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(125, 78, 91, 110),
        ),
        child: Stack(
          children: [
            imgPath == null
                ? UserImg()
                : ClipOval(
                  child: Image.file(
                    imgPath!,
                    width: 146,
                    height: 146,
                    fit: BoxFit.cover,
                  ),
                ),
            Positioned(
              left: 104,
              bottom: -12,
              child: IconButton(
                onPressed: () async {
                  await  chooseGalleryOrCamera();

                  if (imgPath != null) {
                    // Upload image to firebase storage
                    final storageRef = FirebaseStorage.instance.ref(imgName);
                    await storageRef.putFile(imgPath!);

                    // Get img url
                    String url = await storageRef.getDownloadURL();
                    users.doc(credential!.uid).update({"imageLink": url,});
                  }
                },
                icon: const Icon(Icons.add_a_photo),
                color: const Color.fromARGB(255, 94, 115, 128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
