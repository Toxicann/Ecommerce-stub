import 'package:flutter/material.dart';

import '../Models/product_model.dart';
import '../Service/api.dart';

class Data extends ChangeNotifier {
  late List<ProductModel> productList = <ProductModel>[];
  late List<ProductModel> newProductList = <ProductModel>[];

  int listIndex = 1;

  fetchData(context) async {
    productList = await getData(context);
    notifyListeners();
  }

  decreaseStock(index) {
    listIndex == 1 ? productList[index].stock-- : newProductList[index].stock--;

    notifyListeners();
  }

  increaseStock(index) {
    listIndex == 1 ? productList[index].stock++ : newProductList[index].stock++;

    notifyListeners();
  }

  filterByCategory(filterValue) {
    if (filterValue == 'No filter') {
      listIndex = 1;
    } else {
      newProductList = productList
          .where((element) => element.category.contains(filterValue))
          .toList();

      listIndex = 2;
    }
    notifyListeners();
  }
}
