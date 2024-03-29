import 'package:clean_arch/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.name,
      required super.description,
      required super.price,
      required super.imgUrl,
      required super.category,
      required this.productId,
      required super.rating});

  final String productId;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['_id'],
      name: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imgUrl: json['image'],
      category: json['category'],
      rating: json['rating']['rate'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': name,
      'description': description,
      'price': price,
      'image': imgUrl,
      'category': category,
      'rating': rating,
    };
  }
}
