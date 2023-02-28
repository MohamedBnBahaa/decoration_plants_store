import 'package:decoration_plants_store/models/products_item.dart';
import 'package:flutter/material.dart';

class RatingAndLocation extends StatelessWidget {
  const RatingAndLocation({Key? key, required this.product}) : super(key: key);
  final Item product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 4.0, right: 12.0,),
              padding: const EdgeInsets.all(4.0,),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 129, 129,),
                borderRadius: BorderRadius.circular(4.0,),
              ),
              child: const Text(
                "New",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              children: getStars(5),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0,),
          child: Row(
            children: [
              const Icon(
                Icons.edit_location,
                size: 24,
                color: Color.fromARGB(168, 3, 65, 27,),
              ),
              Text(
                product.location,
                style: const TextStyle(fontSize: 18,),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getStars(int count) => List.generate(
    count,
        (index) => const Icon(
      Icons.star,
      size: 24,
      color: Color.fromARGB(255, 255, 191, 0,),
    ),
  );
}
