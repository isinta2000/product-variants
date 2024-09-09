import 'package:flutter/material.dart';
import 'screens/product_options_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Variants App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductOptionsScreen(),
    );
  }
}
