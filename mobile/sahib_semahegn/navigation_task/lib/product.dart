class Product {
  Product(
      {this.imageUrl = 'images/placeholder.jpg',
      required this.category,
      required this.description,
      required this.productName,
      required this.ratings,
      required this.price,
      this.avalaibleSizes = const []});

  String imageUrl;
  String productName;
  String category;
  double ratings;
  int price;
  List<int> avalaibleSizes;
  String description;
  static int id = 0;
  int productId = id + 1;

  update(Product product) {
    imageUrl = product.imageUrl;
    productName = product.productName;
    category = product.category;
    ratings = product.ratings;
    price = product.price;
    avalaibleSizes = product.avalaibleSizes;
    description = product.description;
  }
}
