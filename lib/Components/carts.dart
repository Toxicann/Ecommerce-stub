import 'package:flutter/material.dart';
import 'dart:developer';

import '../Provider/data.dart';
import '../Provider/cart.dart';

class Carts extends StatefulWidget {
  const Carts({
    Key? key,
    required this.cart,
    required this.data,
  }) : super(key: key);

  final Cart cart;
  final Data data;

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 500,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.cart.count,
            itemBuilder: (BuildContext context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    width: 120,
                    height: 125,
                    child: const Image(
                      image: AssetImage('assets/fantechHeadset.jpg'),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(widget.cart.cartList[index].name),
                      Text(
                          'Total Rs. ${widget.cart.cartList[index].price * widget.cart.cartList[index].totalItems}'),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: widget.cart.cartList[index].totalItems < 1
                        ? null
                        : () {
                            widget.cart.decrementItems(index);
                            final dataIndex = widget.data.productList
                                .indexWhere((element) =>
                                    element.id ==
                                    widget.cart.cartList[index].id);
                            widget.data.increaseStock(dataIndex);
                            widget.cart.totalPrice();
                            setState(() {});
                          },
                  ),
                  Text('${widget.cart.cartList[index].totalItems}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: widget.data.productList
                                .where((element) {
                                  return element.id ==
                                      widget.cart.cartList[index].id;
                                })
                                .first
                                .stock <
                            1
                        ? null
                        : () {
                            widget.cart.incrementItems(index);
                            final dataIndex = widget.data.productList
                                .indexWhere((element) =>
                                    element.id ==
                                    widget.cart.cartList[index].id);
                            widget.data.decreaseStock(dataIndex);
                            widget.cart.totalPrice();
                            setState(() {});
                          },
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Total Rs. ${widget.cart.totalSum}'),
            ElevatedButton.icon(
              icon: const Icon(Icons.payment),
              label: const Text('Checkout'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.secondary)),
              onPressed: widget.cart.count < 1 || widget.cart.totalSum == 0
                  ? null
                  : () {
                      Navigator.pushNamed(context, '/checkout');
                    },
            )
          ],
        ),
      ],
    );
  }
}
