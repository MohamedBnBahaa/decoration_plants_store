import 'package:decoration_plants_store/constants/colors.dart';
import 'package:decoration_plants_store/pages/register/register.dart';
import 'package:decoration_plants_store/pages/reset_password/reset_password.dart';
import 'package:decoration_plants_store/provider/google_sign_in.dart';
import 'package:decoration_plants_store/shared/have_an_account.dart';
import 'package:decoration_plants_store/shared/my_elevated_button.dart';
import 'package:decoration_plants_store/shared/my_text_form_field.dart';
import 'package:decoration_plants_store/shared/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      //final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code}");
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      backgroundColor: scaffoldGrey,
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("Sign in"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextFormField(
                controller: emailController,
                whatType: TextInputType.emailAddress,
                isPassword: false,
                hintForText: "Enter your Email",
                suffixIcon: const Icon(Icons.email),
              ),
              MyTextFormField(
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
              MyElevatedButton(
                onPressedBtn: (){
                  signIn();
                },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white,)
                    : const Text("Sign in", style: TextStyle(fontSize: 18),),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResetPassword(),),
                  );
                },
                child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 18,
                      color: btnGreen,
                      decoration: TextDecoration.underline,
                    ),
                ),
              ),


              // HaveAnAccount(
              //   onPressed: toRegister(),
              //   haveAnAccount: "Do not have an account? ",
              //   sign: "Sign up",
              // ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Do not have an account? ",
                    style: TextStyle(fontSize: 20.0,),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: btnGreen,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),



             //  const SizedBox(
             //    height: 18,
             //  ),
             //  SizedBox(
             //    width: 296,
             //    child: Row(
             //      children: const [
             //        Expanded(
             //            child: Padding(
             //              padding: EdgeInsets.all(4.0),
             //              child: Divider(
             //                thickness: 0.8,
             //              ),
             //            ),
             //        ),
             //        Text(
             //          "OR",
             //          style: TextStyle(fontSize: 16,),
             //        ),
             //        Expanded(
             //            child: Padding(
             //              padding: EdgeInsets.all(4.0),
             //              child: Divider(
             //                thickness: 0.8,
             //              ),
             //            ),
             //        ),
             //      ],
             //    ),
             //  ),
             //
             //  //https://docs.flutter.dev/deployment/android
             //  Container(
             //    margin: const EdgeInsets.symmetric(vertical: 28),
             //    child: GestureDetector(
             //      onTap: () {
             //        googleSignInProvider.googlelogin();
             //      },
             //      child:
             //      // Container(
             //      //   padding: EdgeInsets.all(12),
             //      //   decoration: BoxDecoration(
             //      //       shape: BoxShape.circle,
             //      //       border: Border.all(
             //      //         // color: Colors.purple,
             //      //           color: Color.fromARGB(255, 200, 67, 79),
             //      //           width: 1,),),
             //      //   child:
             //        SvgPicture.asset(
             //          "assets/icons/icons8-google.svg",
             //          color: btnGreen,
             //          height: 36,
             //        ),
             //      ),
             //    ),
             // // ),

            ],
          ),
        ),
      ),
    );
  }

  // toRegister(){
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const Register(),
  //     ),
  //   );
  // }
}
