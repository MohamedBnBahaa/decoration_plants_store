import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.whatType,
    required this.isPassword,
    required this.hintForText,
    this.controller,
    this.validator,
    this.autovalidateMode,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  final TextInputType whatType;
  final bool isPassword;
  final String hintForText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0,),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: autovalidateMode,
        controller: controller,
        keyboardType: whatType,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintForText,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          filled: true,
        ),
      ),
    );
  }
}
