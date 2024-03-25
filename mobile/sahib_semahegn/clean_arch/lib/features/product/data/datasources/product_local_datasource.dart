import 'dart:convert';

import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalSource {
  
  Future<List<ProductModel>> getLatestCachedProducts();

  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalSourceImpl implements ProductLocalSource {
  final SharedPreferences dataSource;

  ProductLocalSourceImpl({required this.dataSource});

   @override
  Future<List<ProductModel>> getLatestCachedProducts() {
   
    final jsonString = dataSource.getString('CACHED_PRODUCTS');

    if (jsonString == null) {
      throw CacheException();
    }
    final jsonMap = jsonDecode(jsonString);

    final productList = jsonMap['products'] as List;

    return Future.value(productList.map((e) => ProductModel.fromJson(e)).toList());
  }
  
  @override
  Future<void> cacheProducts(List<ProductModel> products) {
    
    final jsonList = products.map((e) => e.toJson()).toList();
    final jsonMap = {'products': jsonList};

    dataSource.setString('CACHED_PRODUCTS', jsonEncode(jsonMap));

    return Future.value();
  }
  
 

  
}