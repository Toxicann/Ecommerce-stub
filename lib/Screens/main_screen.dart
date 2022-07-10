import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/products.dart';
import '../Components/carts.dart';
import '../Provider/data.dart';
import '../Provider/cart.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final data = Provider.of<Data>(context, listen: false);
    data.fetchData(context);
  }

  // void addtoCart(item) {
  //   cartList.add(CartModel(
  //     id: item.id,
  //     name: item.name,
  //     image: item.image,
  //     price: item.price,
  //     totalItems: item.totalItems,
  //     createDate: item.createDate,
  //     category: item.category,
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(currentIndex == 0 ? 'Product' : 'Cart'),
        centerTitle: true,
        backgroundColor: currentIndex == 0
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              data.fetchData(context);
              cart.cartList = [];
              cart.totalPrice();
            },
          ),
        ],
      ),
      body: currentIndex == 0
          ? Products(data: data, cart: cart)
          : Carts(cart: cart, data: data),
      bottomNavigationBar: bottomNav(context),
    );
  }

  BottomNavigationBar bottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: currentIndex,
      onTap: (index) => setState(() => currentIndex = index),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Product',
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          label: 'Cart',
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}

