
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/product/data/datasources/product_local_datasource.dart';
import 'package:clean_arch/features/product/data/datasources/product_remote_source.dart';
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
  Future<Either<Failure, void>> CreateProductUsecase(Product product) {
    
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> DeleteProductUsecase(String productId) {
    
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> UpdateProductUsecase(Product product) {
    
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> getProduct(String productId) {
   
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() {
    
    throw UnimplementedError();
  }}