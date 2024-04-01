
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class FilterProductsUsecase extends Usecase<void, FilterProductsParams> {
  FilterProductsUsecase({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, List<Product>>> call(FilterProductsParams params) async {
    return await repository.filterProducts(params.title);
  }
}

class FilterProductsParams {
  final String title;

  FilterProductsParams({required this.title});
}