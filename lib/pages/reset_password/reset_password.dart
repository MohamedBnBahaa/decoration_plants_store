import 'package:decoration_plants_store/constants/colors.dart';
import 'package:decoration_plants_store/pages/sign_in/sign_in.dart';
import 'package:decoration_plants_store/shared/my_elevated_button.dart';
import 'package:decoration_plants_store/shared/my_text_form_field.dart';
import 'package:decoration_plants_store/shared/show_snack_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  resetPassword() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login(),),
        );
      }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldGrey,
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("Reset Password"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter your email to rest your password.",
                  style: TextStyle(fontSize: 18,),
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
              MyElevatedButton(
                onPressedBtn: () async {
                  if (_formKey.currentState!.validate()) {
                    resetPassword();
                  }else {
                    showSnackBar(context, "Enter a valid email");
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white,)
                    : const Text("Reset Password", style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
