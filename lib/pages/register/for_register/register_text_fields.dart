import 'package:decoration_plants_store/shared/my_text_form_field.dart';
import 'package:decoration_plants_store/pages/register/for_register/password_requirements.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class RegisterTextFields extends StatefulWidget {
  const RegisterTextFields({Key? key}) : super(key: key);

  @override
  State<RegisterTextFields> createState() => _RegisterTextFieldsState();
}

class _RegisterTextFieldsState extends State<RegisterTextFields> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool isPasswordHasMin8Characters = false;
  bool isPasswordHasNumber = false;
  bool isPasswordHasUppercase = false;
  bool isPasswordHasLowercase = false;
  bool isPasswordHasSpecialCharacters = false;

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
    return Form(
      key: _formKey,
        child: Column(
          children: [
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
          ],
        ),
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
}
