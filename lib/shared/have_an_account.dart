import 'package:decoration_plants_store/constants/colors.dart';
import 'package:flutter/material.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({
    Key? key,
    required this.onPressed,
    required this.haveAnAccount,
    required this.sign
  }) : super(key: key);
  final void Function()? onPressed;
  final String haveAnAccount;
  final String sign;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          haveAnAccount,
          // "Already have an account? ",
          style: const TextStyle(fontSize: 20.0,),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            sign,
            // "Sign in",
            style: const TextStyle(
              fontSize: 20.0,
              color: btnGreen,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
