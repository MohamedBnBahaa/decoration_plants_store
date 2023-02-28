import 'package:decoration_plants_store/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCheckOut extends StatelessWidget {
  const ProductCheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return SingleChildScrollView(
      child: SizedBox(
        height: 520,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: cart.selectedProduct.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(cart.selectedProduct[index].name),
                  subtitle: Text(
                      "${cart.selectedProduct[index].price} - ${cart.selectedProduct[index].location}"),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      cart.selectedProduct[index].imgPath,
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        cart.removeItem(cart.selectedProduct[index]);
                        //cart.reducePriceOfRemovedProduct(cart.selectedProduct[index]);
                      },
                      icon: const Icon(Icons.remove)),
                ),
              );
            }),
      ),
    );
  }
}
