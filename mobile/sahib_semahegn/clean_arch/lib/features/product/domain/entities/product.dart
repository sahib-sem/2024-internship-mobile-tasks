import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imgUrl,
    required this.category,
  });
  String name;
  String description;
  double price;
  String imgUrl;
  String category;

  @override
  List<Object?> get props => [name, description, price, imgUrl, category];
}
