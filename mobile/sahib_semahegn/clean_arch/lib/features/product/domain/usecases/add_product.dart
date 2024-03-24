
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class AddProduct extends Usecase<void, Params> {

  AddProduct({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, void>> call(Params params) async {
    
    return await repository.addProduct(params.product);
  }


}

class Params {

  final Product product;

  Params({required this.product});
}