import 'dart:convert';

import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteSource {
  Future<List<ProductModel>> getProducts();

  Future<ProductModel> getProduct(String productId);

  Future<void> createProduct(ProductModel product);

  Future<void> updateProduct(ProductModel product);

  Future<void> deleteProduct(String productId);
}

class ProductRemoteSourceImpl implements ProductRemoteSource {
  ProductRemoteSourceImpl({required this.client});
  final String baseUrl =
      'https://products-api-5a5n.onrender.com/api/v1/products';

  final http.Client client;

  @override
  Future<void> createProduct(ProductModel product) async {
    final result = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (result.statusCode != 201) throw ServerException();
  }

  @override
  Future<void> deleteProduct(String productId) async {
    final result = await client.delete(
      Uri.parse('$baseUrl/$productId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (result.statusCode != 200) throw ServerException();
  }

  @override
  Future<ProductModel> getProduct(String productId) async {
    final result = await client.get(
      Uri.parse('$baseUrl/$productId}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (result.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(result.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final result = await client.get(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (result.statusCode == 200) {
      final Map<String, dynamic> resultMap = jsonDecode(result.body);
      final List<dynamic> products = resultMap['products'];

      return products.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    
    final result = await client.patch(
      Uri.parse('$baseUrl/${product.productId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (result.statusCode != 200) throw ServerException();
  }
}
