import 'package:product_2/product.dart';

class ProductManager {
  List<Product> products = [];

  void displayProducts() {
    for (var product in products) {
      print('products in the list');
      print(product);
    }
  }

  void addProduct(Product product) {

    products.add(product);

  }

  void findById(int givenId) {

    var filteredProducts = products.where((element) => element.productId == givenId);

    for (var product in filteredProducts) {
      print(product);
    }
  }

  void updateProduct(int givenId,{String? name, String? description, double? price } ){

    var filteredProducts = products.where((element) => element.productId == givenId);

    for (var product in filteredProducts) {
      
      product.name = name ?? product.name;
      product.description = description ?? product.description;
      product.price = price ?? product.price;
    }

  }

  Product? deleteProduct(int givenId) {

    int index = products.indexWhere((element) => element.productId == givenId);

    if (index == -1) {
      return null;
    }
    

    return products.removeAt(index);
  }


}
