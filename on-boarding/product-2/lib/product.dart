class Product {

  static int currId = 0;

  Product(this.name, this.description, this.price){

    productId = currId + 1;
    currId += 1;
    
  }

  String name;
  String description;
  double price;
  int productId = 0;

  @override
  String toString() {

    return '''
    Product 
    name: $name 
    description: $description
    price: $price
''';
  }
}