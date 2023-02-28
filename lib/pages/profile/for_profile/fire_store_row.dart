import 'package:flutter/material.dart';

class FireStoreRow extends StatelessWidget {
  const FireStoreRow({
    Key? key,
    required this.text,
    required this.myDialog,
    required this.deleteField,
  }) : super(key: key);

  final String text;
  final Function deleteField;
  final Function myDialog;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                deleteField;
              },
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                myDialog;
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ],
    );
  }
}
