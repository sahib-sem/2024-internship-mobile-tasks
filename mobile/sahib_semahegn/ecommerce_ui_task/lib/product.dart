class Product {
  Product(
      {required this.imageUrl,
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
}
