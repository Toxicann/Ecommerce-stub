import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/products.dart';
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
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.count,
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
                              Text(cart.cartList[index].name),
                              Text(
                                  'Total Rs. ${cart.cartList[index].price * cart.cartList[index].totalItems}'),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: cart.cartList[index].totalItems < 1
                                ? null
                                : () {
                                    cart.decrementItems(index);
                                    final dataIndex = data.productList
                                        .indexWhere((element) =>
                                            element.id ==
                                            cart.cartList[index].id);
                                    data.increaseStock(dataIndex);
                                    cart.totalPrice();
                                    setState(() {});
                                  },
                          ),
                          Text('${cart.cartList[index].totalItems}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed:
                                data.productList[cart.cartList[index].id - 1]
                                            .stock <
                                        1
                                    ? null
                                    : () {
                                        cart.incrementItems(index);
                                        final dataIndex = data.productList
                                            .indexWhere((element) =>
                                                element.id ==
                                                cart.cartList[index].id);
                                        data.decreaseStock(dataIndex);
                                        cart.totalPrice();
                                        setState(() {});
                                      },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Total Rs. ${cart.totalSum}'),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.payment),
                      label: const Text('Checkout'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.secondary)),
                      onPressed:
                          cart.count < 1 || cart.totalSum == 0 ? null : () {},
                    )
                  ],
                ),
              ],
            ),
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
