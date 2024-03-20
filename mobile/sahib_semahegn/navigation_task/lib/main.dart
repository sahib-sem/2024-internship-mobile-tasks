import 'package:ecommerce_ui_task/add_product.dart';
import 'package:ecommerce_ui_task/home_screen.dart';
import 'package:ecommerce_ui_task/product_detail_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ecommerce app',
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/add_product': (context) => AddProductPage(),
      '/product_detail': (context) => const ProductDetail(),
      '/edit_product': (context) => AddProductPage(edit: true)
    },
  ));
}
