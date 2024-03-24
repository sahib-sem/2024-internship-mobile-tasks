import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProduct extends Usecase<void, Params> {
  UpdateProduct({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.updateProduct(params.product);
  }
}

class Params {
  final Product product;

  Params({required this.product});
}