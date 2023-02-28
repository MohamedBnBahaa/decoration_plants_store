import 'package:decoration_plants_store/constants/colors.dart';
import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    Key? key,
    required this.onPressedBtn,
    required this.child,
  }) : super(key: key);

  final Function onPressedBtn;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0,),
      child: ElevatedButton(
        onPressed: (){onPressedBtn();},
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(btnGreen),
          padding: const MaterialStatePropertyAll(EdgeInsets.all(12.0,),),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0,),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
