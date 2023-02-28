import 'package:decoration_plants_store/constants/colors.dart';
import 'package:flutter/material.dart';

class FromWhere extends StatelessWidget {
  const FromWhere({Key? key, required this.fromWhereText}) : super(key: key);
  final String fromWhereText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: btnGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          fromWhereText,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
