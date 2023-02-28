import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decoration_plants_store/constants/colors.dart';
// import 'package:decoration_plants_store/pages/register/for_register/register_text_fields.dart';
// import 'package:decoration_plants_store/pages/register/for_register/register_user_photo.dart';
// import 'package:decoration_plants_store/shared/have_an_account.dart';
import 'package:decoration_plants_store/pages/sign_in/sign_in.dart';
import 'package:decoration_plants_store/pages/verify_email/verify_email.dart';
import 'package:decoration_plants_store/shared/my_elevated_button.dart';
import 'package:decoration_plants_store/shared/my_text_form_field.dart';
import 'package:decoration_plants_store/pages/register/for_register/password_requirements.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../shared/show_snack_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' show basename;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool isLoading = false;
  bool isPasswordHasMin8Characters = false;
  bool isPasswordHasNumber = false;
  bool isPasswordHasUppercase = false;
  bool isPasswordHasLowercase = false;
  bool isPasswordHasSpecialCharacters = false;
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

  onPasswordChanged(String password) {
    isPasswordHasMin8Characters = false;
    isPasswordHasNumber = false;
    isPasswordHasUppercase = false;
    isPasswordHasLowercase = false;
    isPasswordHasSpecialCharacters = false;

    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPasswordHasMin8Characters = true;
      }
      if (password.contains( RegExp(r'[0-9]'))) {
        isPasswordHasNumber = true;
      }
      if (password.contains( RegExp(r'[A-Z]'))) {
        isPasswordHasUppercase = true;
      }
      if (password.contains( RegExp(r'[a-z]'))) {
        isPasswordHasLowercase = true;
      }
      if (password.contains( RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        isPasswordHasSpecialCharacters = true;
      }
    });
  }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);
      String url = await storageRef.getDownloadURL();


      CollectionReference users = FirebaseFirestore.instance.collection('my users');

      users
            .doc(credential.user?.uid)
            .set({
              'imageLink': url,
              'username': usernameController.text,
              'age': ageController.text,
              'title': titleController.text,
              'email': emailController.text,
              'password': passwordController.text,
            })
            .then((value) => showSnackBar(context, "User Added"))
            .catchError((error) => showSnackBar(context, "Failed to add user: $error"));


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "ERROR - Please try again later");
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldGrey,

      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("Register"),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0,),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  // const RegisterUserPhoto(),


                  Container(
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
                  ),



                  // const SizedBox(
                  //   height: 32,
                  // ),
                  //
                  // const RegisterTextFields(),



                  MyTextFormField(
                    controller: usernameController,
                    whatType: TextInputType.text,
                    isPassword: false,
                    hintForText: "Enter your Username",
                    suffixIcon: const Icon(Icons.person),
                  ),
                  MyTextFormField(
                    controller: ageController,
                    whatType: TextInputType.number,
                    isPassword: false,
                    hintForText: "Enter your age",
                    suffixIcon: const Icon(Icons.view_day),
                  ),
                  MyTextFormField(
                    controller: titleController,
                    whatType: TextInputType.text,
                    isPassword: false,
                    hintForText: "Enter your job title",
                    suffixIcon: const Icon(Icons.work),
                  ),
                  MyTextFormField(
                    // we return "null" when something is valid
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? "Enter a valid email"
                          : null;
                      },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    whatType: TextInputType.emailAddress,
                    isPassword: false,
                    hintForText: "Enter your Email",
                    suffixIcon: const Icon(Icons.email),
                  ),
                  MyTextFormField(
                    onChanged: (password) {
                      onPasswordChanged(password);
                    },
                    // we return "null" when something is valid
                    validator: (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                      },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    whatType: TextInputType.text,
                    isPassword: isVisible ? true : false,
                    hintForText: "Enter your Password",
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                    ),
                  ),


                  PasswordRequirements(
                    color: isPasswordHasMin8Characters ? Colors.green : Colors.white,
                    text: "At least 8 characters",
                  ),
                  PasswordRequirements(
                    color: isPasswordHasNumber ? Colors.green : Colors.white,
                    text: "At least 1 number",
                  ),
                  PasswordRequirements(
                    color: isPasswordHasUppercase ? Colors.green : Colors.white,
                    text: "Has Uppercase",
                  ),
                  PasswordRequirements(
                    color: isPasswordHasLowercase ? Colors.green : Colors.white,
                    text: "Has Lowercase",
                  ),
                  PasswordRequirements(
                    color: isPasswordHasSpecialCharacters ? Colors.green : Colors.white,
                    text: "Has Special Characters",
                  ),


                  MyElevatedButton(
                    onPressedBtn: () async {
                      if (_formKey.currentState!.validate() && imgName != null && imgPath != null) {
                        await register();
                        //https://andrewzuo.com/notes-on-the-lint-do-not-use-buildcontexts-across-async-gaps-b0931bf8dad5
                        //https://dart-lang.github.io/linter/lints/use_build_context_synchronously.html
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const VerifyEmailPage(),),
                          );
                        }
                      } else {
                        showSnackBar(context, "Add a photo and Enter a valid email and password");
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white,)
                        : const Text("Register", style: TextStyle(fontSize: 18),),
                  ),

                  // HaveAnAccount(
                  //   onPressed: toSignIn(),
                  //   haveAnAccount: "Already have an account? ",
                  //   sign: "Sign in",
                  // ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(fontSize: 20.0,),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          );
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: btnGreen,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // toSignIn(){
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => const Login()),
  //   );
  // }
}
