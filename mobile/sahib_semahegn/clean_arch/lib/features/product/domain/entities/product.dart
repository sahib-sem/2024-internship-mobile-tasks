import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imgUrl,
    required this.category,
  });
  String id;
  String name;
  String description;
  double price;
  String imgUrl;
  String category;

  @override
  List<Object?> get props => [id, name, description, price, imgUrl, category];
}
