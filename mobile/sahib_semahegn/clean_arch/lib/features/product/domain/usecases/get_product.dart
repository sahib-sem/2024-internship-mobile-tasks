import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ViewProductUsecase extends Usecase<Product, GetProductParams> {
  ViewProductUsecase({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, Product>> call(GetProductParams params) async {
    return await repository.getProduct(params.productId);
  }
}

class GetProductParams {
  final String productId;

  GetProductParams({required this.productId});
}
