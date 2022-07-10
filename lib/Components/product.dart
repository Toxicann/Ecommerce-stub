import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  const Product({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          const Image(
            image: AssetImage('assets/fantechHeadset.jpg'),
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Name $i'),
              Text('Price $i'),
            ],
          ),
          const Text('test'),
          const Text('test'),
        ],
      ),
    );
  }
}
