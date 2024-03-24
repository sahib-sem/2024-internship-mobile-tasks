import 'package:clean_arch/features/product/data/models/product_model.dart';

abstract class ProductLocalSource {
  
  Future<List<ProductModel>> getLatestCachedProducts();

  Future<void> cacheProducts(List<ProductModel> products);
}