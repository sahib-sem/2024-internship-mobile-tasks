import 'package:clean_arch/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.name,
      required super.description,
      required super.price,
      required super.imgUrl,
      required super.category,
      required super.productId,
      required super.rating});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['_id'],
      name: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imgUrl: json['image'],
      category: json['category'],
      rating: convertRating(json['rating'] as Map<String, dynamic>),
    );
  }

  Product toProduct() {
    return Product(
      name: name,
      description: description,
      price: price,
      imgUrl: imgUrl,
      category: category,
      rating: rating,
      productId: productId,
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

Map <String, double> convertRating(Map<String, dynamic> json) {
    return {
      "rate": (json['rate'] as int).toDouble(),
      "count": (json['count'] as int).toDouble(),
   };
   }



   