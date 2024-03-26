
import 'dart:convert';

import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture.dart';


void main() {

  ProductModel productModel = ProductModel(
    productId: '65f015b8067e341298b2aa56',
    name: 'Product 2',
    description: 'This is the description for product 2',
    price: 300,
    imgUrl: 'https://via.placeholder.com/500x500.png?text=Product+Image',
    category: 'Products',
  );

  test('should be a subclass of Product entity', () async {
    // assert
    expect(productModel, isA<Product>());
  });

  test('should return a valid model when the JSON is valid', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('product.json'));
    // act
    final result = ProductModel.fromJson(jsonMap);
    // assert
    expect(result, productModel);
  });

  test('should return a JSON map containing the proper data', () async {
    // act
    final result = productModel.toJson();
    // assert
    final expectedMap = {
      'title': 'Product 2',
      'price': 300,
      'description': 'This is the description for product 2',
      'category': 'Products',
      'image': 'https://via.placeholder.com/500x500.png?text=Product+Image',
    };
    expect(result, expectedMap);
  });

}