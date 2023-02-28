import 'package:decoration_plants_store/constants/colors.dart';
import 'package:decoration_plants_store/pages/check_out/for_check_out/pay_button.dart';
import 'package:decoration_plants_store/pages/check_out/for_check_out/product_check_out.dart';
import 'package:decoration_plants_store/shared/app_bar_actions.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldGrey,

      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("Check out"),
        actions: const [AppBarActions(),],
      ),

      body: Column(
        children: const [
          ProductCheckOut(),

          SizedBox(height: 64,),

          PayButton(),
        ],
      ),
    );
  }
}
