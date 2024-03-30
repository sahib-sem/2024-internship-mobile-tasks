import 'dart:io';

import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class CreateProductUsecase extends Usecase<void, AddProductParams> {
  CreateProductUsecase({required this.repository});

  ProductRepository repository;

  @override
  Future<Either<Failure, void>> call(AddProductParams params) async {
    return await repository.createProdut(params.product, image: params.image);
  }
}

class AddProductParams {
  final ProductModel product;
  File? image;

  AddProductParams({required this.product, this.image});
}
