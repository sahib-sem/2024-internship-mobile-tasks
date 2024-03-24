
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductList extends Usecase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProductList({required this.repository});

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}

