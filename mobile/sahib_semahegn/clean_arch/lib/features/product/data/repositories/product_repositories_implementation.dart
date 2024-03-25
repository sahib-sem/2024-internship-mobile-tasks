
import 'dart:math';

import 'package:clean_arch/core/error/exception.dart';
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
  Future<Either<Failure, void>> createProdut(ProductModel product) async {
    
   try {

      if (await networkInfo.isConnected) {
        await productRemoteSource.createProduct(product);
      return const Right(null);

      }
      else {
        return Left(NetworkFailure());
      }
      
      
  
    }  on ServerException {
      return Left(ServerFailure());
   } 

  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    
    try {

      if (await networkInfo.isConnected) {
        await productRemoteSource.deleteProduct(productId);

        return const Right(null);

      } else {
        return Left(NetworkFailure());
      }

      
      
    }  on ServerException {
      return Left(ServerFailure());
  }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String productId) async {

    try {

      if (await networkInfo.isConnected) {
        final remoteProduct = await productRemoteSource.getProduct(productId);
        return Right(remoteProduct);
      } else {
        return Left(NetworkFailure());
      }
      
    }  on ServerException {
      return Left(ServerFailure());
    }
    

  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {

    try {

      if (await networkInfo.isConnected) {
        final remoteProducts = await productRemoteSource.getProducts();
        return Right(remoteProducts);
      } else {
        
        final localProducts = await productLocalSource.getLatestCachedProducts();
        return Right(localProducts);
      }
      
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
    
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductModel product) async {
    
    try {

      if (await networkInfo.isConnected) {
        await productRemoteSource.updateProduct(product);
        return const Right(null);
      } else {
        return Left(NetworkFailure());
      }
      
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}