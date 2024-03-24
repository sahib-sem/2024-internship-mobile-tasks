import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProductUsecase extends Usecase<void, Params> {
  UpdateProductUsecase({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.updateProduct(params.product);
  }
}

class Params {
  final ProductModel product;

  Params({required this.product});
}
