import 'package:flutter/material.dart';

import 'Screens/login_screen.dart';
import 'Screens/main_screen.dart';

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
        '/': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        // '/cart': (context) => const CartScreen(),
      },
    );
  }
}
