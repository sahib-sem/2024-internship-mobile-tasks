import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct(String productId);
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, void>> addProduct(Product product);
  Future<Either<Failure, void>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String productId);
}
