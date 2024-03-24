import 'package:clean_arch/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.name,
      required super.description,
      required super.price,
      required super.imgUrl,
      required super.category,
      required this.productId});

  String productId;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['_id'],
      name: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imgUrl: json['image'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': productId,
      'title': name,
      'description': description,
      'price': price,
      'image': imgUrl,
      'category': category,
    };
  }
}
