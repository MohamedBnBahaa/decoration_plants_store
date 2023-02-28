import 'package:decoration_plants_store/models/products_item.dart';
import 'package:decoration_plants_store/pages/product_details/product_details.dart';
import 'package:decoration_plants_store/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyOfHome extends StatelessWidget {
  const BodyOfHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 32,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(product: items[index],),
                  ),
                );
              },
              child: GridTile(
                footer: GridTileBar(
                  // backgroundColor: Color.fromARGB(66, 73, 127, 110),
                  leading: Text("\$${items[index].price}"),
                  title: const Text(
                    "",
                  ),
                  trailing: IconButton(
                      color: const Color.fromARGB(255, 62, 94, 70),
                      onPressed: () {
                        cart.addItem(items[index]);
                        cart.productPrice(items[index]);
                      },
                      icon: const Icon(Icons.add)),
                ),
                child: Stack(children: [
                  Positioned(
                    top: -2,
                    bottom: -8,
                    right: 0,
                    left: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(56),
                      child: Image.asset(
                        items[index].imgPath,
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }),
    );
  }
}
