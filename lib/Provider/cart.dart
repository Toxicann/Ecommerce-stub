import 'package:flutter/material.dart';

import '../Models/cart_model.dart';

class Cart extends ChangeNotifier {
  List<CartModel> cartList = <CartModel>[];

  int get count => cartList.length;

  double totalSum = 0;

  addToCart(object) {
    cartList.add(CartModel(
      id: object.id,
      name: object.name,
      image: object.image,
      price: double.parse(object.price.replaceAll('\$', '')),
      totalItems: 1,
      createDate: object.createDate,
      category: object.category,
    ));

    notifyListeners();
  }

  incrementItems(index) {
    cartList[index].totalItems++;
    notifyListeners();
  }

  decrementItems(index) {
    cartList[index].totalItems--;
    notifyListeners();
  }

  totalPrice() {
    totalSum = 0;
    for (var element in cartList) {
      totalSum += element.price * element.totalItems;
    }
    notifyListeners();
  }
}
