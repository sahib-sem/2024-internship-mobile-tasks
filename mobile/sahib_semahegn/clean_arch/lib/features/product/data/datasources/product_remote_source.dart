import 'package:clean_arch/features/product/data/models/product_model.dart';

abstract class ProductRemoteSource {


  Future<List<ProductModel>> getProducts();

  Future<ProductModel> getProduct(String productId);  

  Future<void> createProduct(ProductModel product);

  Future<void> updateProduct(ProductModel product);

  Future<void> deleteProduct(String productId);


}