import 'package:flutter/material.dart';

import '../Provider/data.dart';

class Products extends StatelessWidget {
  const Products({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Data data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisSpacing: 10,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.75),
        itemCount: data.productList.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: EdgeInsets.all(8.0),
            child: Expanded(
              child: Column(
                children: <Widget>[
                  const Image(
                    image: AssetImage('assets/fantechHeadset.jpg'),
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(data.productList[index].name),
                      Text(data.productList[index].price),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
