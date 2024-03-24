
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/product/data/datasources/product_local_datasource.dart';
import 'package:clean_arch/features/product/data/datasources/product_remote_source.dart';
import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {

  ProductRepositoryImpl({
    required this.networkInfo,
    required this.productRemoteSource,
    required this.productLocalSource,
  });

  NetworkInfo networkInfo;
  ProductRemoteSource productRemoteSource;
  ProductLocalSource productLocalSource;

  @override
  Future<Either<Failure, void>> createProdut(ProductModel product) {
    // TODO: implement createProdut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProduct(String productId) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }

}