import 'package:flutter/material.dart';

import 'Screens/login_screen.dart';
import 'Screens/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff5065a8),
          secondary: const Color(0xffaf9a57),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/product': (context) => const ProductScreen(),
        // '/cart': (context) => const CartScreen(),
      },
    );
  }
}
