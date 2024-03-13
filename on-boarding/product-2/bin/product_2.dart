

import 'dart:io';

import 'package:product_2/product.dart';
import 'package:product_2/product_manger.dart';

void main(List<String> arguments) {
  
  var productManager = ProductManager();

  bool run = true;

  while (run) {

    print(
      '''
      Welcome to ecommerce app!! 
      choose what you want to do 

      1. Add product 
      2. display all products 
      3. find a product by id 
      4. update a product
      5. delete a product
      6. exit

      ''');

      int? userInput = int.parse(stdin.readLineSync() ?? '6');

      switch(userInput) {

        case 1:
          stdout.write('name: ');
          String name = stdin.readLineSync() ?? 'unknown';
          print('');
          stdout.write('description: ');
          String description = stdin.readLineSync() ?? '';
          print('');

          stdout.write('price: ');
          double price = double.parse(stdin.readLineSync() ?? '0.0');

          var product = Product(name, description, price);

          productManager.addProduct(product); 
          print('you have created this product');
          print(product);

        case 2:

          productManager.displayProducts();

        case 3:

          stdout.write('Enter the id of the product you want to find: ');
          int givenId = int.parse(stdin.readLineSync() ?? '0');

          productManager.findById(givenId);
        
        case 4:

          stdout.write('Enter the id of the product you want to update: ');
          int givenId = int.parse(stdin.readLineSync() ?? '0');

          stdout.write('name: ');
          String? name = stdin.readLineSync();
          print('');
          stdout.write('description: ');
          String? description = stdin.readLineSync();
          print('');
          stdout.write('price: ');
          double? price = double.parse(stdin.readLineSync() ?? '0.0');

          productManager.updateProduct(givenId, name: name, description: description, price: price);

        case 5:

          stdout.write('Enter the id of the product you want to delete: ');
          int givenId = int.parse(stdin.readLineSync() ?? '0');

          productManager.deleteProduct(givenId);

        case 6:
          
            run = false;
            break;
        
        default:
          print('invalid input');



        
      }
  }

}
