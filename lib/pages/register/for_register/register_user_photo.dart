import 'dart:io';
import 'dart:math';
import 'package:decoration_plants_store/shared/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class RegisterUserPhoto extends StatefulWidget {
  const RegisterUserPhoto({Key? key}) : super(key: key);

  @override
  State<RegisterUserPhoto> createState() => _RegisterUserPhotoState();
}

class _RegisterUserPhotoState extends State<RegisterUserPhoto> {
  File? imgPath;
  String? imgName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(125, 78, 91, 110),
      ),
      child: Stack(
        children: [
          imgPath == null
              ? const CircleAvatar(
                backgroundColor:
                Color.fromARGB(255, 225, 225, 225),
                radius: 72,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              )
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
              },
              icon: const Icon(Icons.add_a_photo),
              color: const Color.fromARGB(255, 94, 115, 128),
            ),
          ),
        ],
      ),
    );
  }

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
}
