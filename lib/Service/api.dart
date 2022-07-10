import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/product_model.dart';

Future<List<ProductModel>> getData(context) async {
  late List<ProductModel> productList = <ProductModel>[];

  try {
    final response = await http.get(
        Uri.parse('https://electronic-ecommerce.herokuapp.com/api/v1/product'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']['product'];
      for (var json in data) {
        productList.add(ProductModel.fromJson(json));
      }
    } else {
      print('error');
    }
  } catch (e) {
    print(e.toString());
  }

  return productList;
}
