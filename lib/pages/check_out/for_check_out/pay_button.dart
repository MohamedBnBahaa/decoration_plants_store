import 'package:decoration_plants_store/constants/colors.dart';
import 'package:decoration_plants_store/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayButton extends StatelessWidget {
  const PayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(btnPink),
        padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      ),
      child: Text(
        "Pay \$${cart.price}",
        style: const TextStyle(fontSize: 18,),
      ),
    );
  }
}
