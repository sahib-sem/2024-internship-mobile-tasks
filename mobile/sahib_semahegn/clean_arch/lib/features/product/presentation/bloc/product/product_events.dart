
import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductEvent {}

class GetProduct extends ProductEvent {
  final String id;

  const GetProduct(this.id);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'GetProduct { id: $id }';
}

class DeleteProduct extends ProductEvent {
  final String id;

  const DeleteProduct(this.id);

  @override
  List<Object> get props => [id];
}

class CreateProduct extends ProductEvent {
  final ProductModel product;

  const CreateProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'CreateProduct { product: $product }';
}

class UpdateProduct extends ProductEvent {
  final ProductModel product;

  const UpdateProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'UpdateProduct { product: $product }';
}