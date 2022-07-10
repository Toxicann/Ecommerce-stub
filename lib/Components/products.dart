import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Provider/data.dart';
import '../Provider/cart.dart';

class Products extends StatelessWidget {
  const Products({
    Key? key,
    required this.data,
    required this.cart,
  }) : super(key: key);

  final Data data;
  final Cart cart;

  String formatDate(date) {
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(date);
    return DateFormat('d-MMM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount: data.productList.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/fantechHeadset.jpg'),
                  fit: BoxFit.cover,
                ),
                Text(data.productList[index].name),
                Text(data.productList[index].price.replaceAll('\$', 'Rs. ')),
                Text('Stock: ${data.productList[index].stock}'),
                Text(formatDate(data.productList[index].createDate)),
                Text(
                  '${data.productList[index].category[0]}, ${data.productList[index].category[1]}',
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_shopping_cart),
                  label: Text(data.productList[index].stock < 1
                      ? 'Out of Stock'
                      : 'Add to cart'),
                  onPressed: data.productList[index].stock < 1
                      ? null
                      : () {
                          data.decreaseStock(index);
                          cart.addToCart(data.productList[index]);
                          cart.totalPrice();
                        },
                )
              ],
            ),
          );
        });
  }
}
