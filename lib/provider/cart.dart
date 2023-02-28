import 'package:decoration_plants_store/models/products_item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {

  List selectedProduct = [];
  double price = 0;

  addItem(Item product) {
    selectedProduct.add(product);
    notifyListeners();
  }

  productPrice(Item product) {
    price += product.price.round();
    notifyListeners();
  }

  removeItem(Item product) {
    selectedProduct.remove(product);
    price -= product.price.round();
    notifyListeners();
  }

  // reducePriceOfRemovedProduct(Item product) {
  //   price -= product.price.round();
  //   notifyListeners();
  // }

}
