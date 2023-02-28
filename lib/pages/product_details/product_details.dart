import 'package:decoration_plants_store/constants/colors.dart';
import 'package:decoration_plants_store/models/products_item.dart';
import 'package:decoration_plants_store/pages/product_details/body_of_details/body_of_details.dart';
import 'package:decoration_plants_store/shared/app_bar_actions.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.product,}) : super(key: key);
  final Item product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("Details"),
        actions: const [AppBarActions(),],
      ),

      body: BodyOfDetails(
        product: product,
      ),
    );
  }
}
