import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.imgUrl,
      required this.category,
      required this.rating,
      required this.productId});
  final String name;
  final String productId;
  final String description;
  final double price;
  final String imgUrl;
  final String category;
  final Map<String, double> rating;

  @override
  List<Object?> get props => [name, description, price, imgUrl, category];
}
