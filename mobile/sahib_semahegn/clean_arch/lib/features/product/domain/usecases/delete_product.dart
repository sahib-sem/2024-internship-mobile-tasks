import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteProductUsecase extends Usecase<void, Params> {
  DeleteProductUsecase({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.DeleteProductUsecase(params.productId);
  }
}

class Params {
  final String productId;

  Params({required this.productId});
}
