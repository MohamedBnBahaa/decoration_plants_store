import 'package:decoration_plants_store/models/products_item.dart';
import 'package:decoration_plants_store/pages/product_details/body_of_details/rating_and_location.dart';
import 'package:decoration_plants_store/pages/product_details/body_of_details/show_details_text.dart';
import 'package:flutter/material.dart';

class BodyOfDetails extends StatelessWidget {
  const BodyOfDetails({Key? key, required this.product,}) : super(key: key);
  final Item product;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(product.imgPath),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            "\$ ${product.price}",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          RatingAndLocation(product: product),
          const ShowDetailsText(),
        ],
      ),
    );
  }
}