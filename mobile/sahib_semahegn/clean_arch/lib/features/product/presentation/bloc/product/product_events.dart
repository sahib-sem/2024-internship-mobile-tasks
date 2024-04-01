
import 'dart:io';

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
  File? image;

  CreateProduct(this.product, {this.image});

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

class FilterProducts extends ProductEvent {
  final String title;

  const FilterProducts({this.title = ""});

  @override
  List<Object> get props => [title];

  @override
  String toString() => 'FilterProducts { title: $title }';
}

// filtering based on category min and max price

class FilterProductsByCategory extends ProductEvent {
  final double minPrice;
  final double maxPrice;
  final String category;

  const FilterProductsByCategory(
      {
      
      required this.category,
      required this.minPrice,
      required this.maxPrice});

  @override
  List<Object> get props => [minPrice, maxPrice , category];

  @override
  String toString() =>
      'FilterProductsByCategory {  minPrice: $minPrice, maxPrice: $maxPrice }';
}