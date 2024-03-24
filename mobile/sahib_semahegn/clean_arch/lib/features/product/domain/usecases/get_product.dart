import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProduct extends Usecase<Product, Params> {
  GetProduct({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, Product>> call(Params params) async {
    return await repository.getProduct(params.productId);
  }
}

class Params {
  final String productId;

  Params({required this.productId});
}
