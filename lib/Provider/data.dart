import 'package:flutter/material.dart';

import '../Models/product_model.dart';
import '../Service/api.dart';

class Data extends ChangeNotifier {
  late List<ProductModel> productList = <ProductModel>[];

  fetchData(context) async {
    productList = await getData(context);
    notifyListeners();
  }

  decreaseStock(index) {
    productList[index].stock--;
    notifyListeners();
  }

  increaseStock(index) {
    productList[index].stock++;
    notifyListeners();
  }
}
