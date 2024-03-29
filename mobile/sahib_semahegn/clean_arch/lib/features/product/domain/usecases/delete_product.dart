import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteProductUsecase extends Usecase<void, DeleteProductParams> {
  DeleteProductUsecase({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, void>> call(DeleteProductParams params) async {
    return await repository.deleteProduct(params.productId);
  }
}

class DeleteProductParams {
  final String productId;

  DeleteProductParams({required this.productId});
}
