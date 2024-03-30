
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/presentation/pages/add_update_product.dart';
import 'package:clean_arch/features/product/presentation/pages/pages.dart';
import 'package:clean_arch/features/product/presentation/pages/product_details.dart';
import 'package:flutter/material.dart';

class ProductRoute {

  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => HomeScreen());
    }

    if (settings.name == AddUpdateProductPage.routeName) {
     ProductArguments args = settings.arguments as ProductArguments;
      return MaterialPageRoute(
        builder: (context) => AddUpdateProductPage(
          args: args,
        ),
      );
    }

    if (settings.name == ProductDetail.routeName) {
      Product product = settings.arguments as Product;
      return MaterialPageRoute(
        builder: (context) => ProductDetail(
          product: product,
        ),
      );
    }

    return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}


class ProductArguments {
  Product? product;
  bool edit;

  ProductArguments({this.product, required this.edit});
}