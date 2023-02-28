import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(
                color: const Color.fromARGB(255, 189, 189, 189),
              ),
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(text, style: const TextStyle(fontSize: 16,),),
        ],
      ),
    );
  }
}
