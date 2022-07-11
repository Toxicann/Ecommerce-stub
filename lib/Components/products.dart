import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Provider/data.dart';
import '../Provider/cart.dart';

class Products extends StatefulWidget {
  const Products({
    Key? key,
    required this.data,
    required this.cart,
  }) : super(key: key);

  final Data data;
  final Cart cart;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String formatDate(date) {
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(date);
    return DateFormat('d-MMM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    var list;

    widget.data.listIndex == 1
        ? list = widget.data.productList
        : list = widget.data.newProductList;

    return Expanded(
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
          ),
          itemCount: list.length,
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
                  Text(list[index].name),
                  Text(list[index].price.replaceAll('\$', 'Rs. ')),
                  Text('Stock: ${list[index].stock}'),
                  Text(formatDate(list[index].createDate)),
                  Text(
                    '${list[index].category[0]}, ${list[index].category[1]}',
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_shopping_cart),
                    label: Text(
                        list[index].stock < 1 ? 'Out of Stock' : 'Add to cart'),
                    onPressed: list[index].stock < 1
                        ? null
                        : () {
                            widget.data.decreaseStock(index);
                            widget.cart.addToCart(list[index]);
                            widget.cart.totalPrice();
                          },
                  )
                ],
              ),
            );
          }),
    );
  }
}
