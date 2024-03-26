import 'dart:convert';

import 'package:clean_arch/core/error/exception.dart';
import 'package:clean_arch/features/product/data/datasources/product_remote_source.dart';
import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture.dart';
import 'remote_datasource_implementation_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  String baseUrl = 'https://products-api-5a5n.onrender.com/api/v1/products';
  MockClient mockClient = MockClient();
  ProductModel productModel =
      ProductModel.fromJson(jsonDecode(fixture('product.json')));
  ProductRemoteSourceImpl productRemoteSource =
      ProductRemoteSourceImpl(client: mockClient);

  group('getProduct', () {
    test(
        'should perform GET with baseURl/productID when remote source getProduct is called',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('product.json'), 200));

      final result =
          await productRemoteSource.getProduct(productModel.productId);

      verify(mockClient.get(
        Uri.parse('$baseUrl/$productModel.productId}'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test(
        'should return ProductModel when the call to remoteSource has a status code of 200',
        () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('product.json'), 200));

      final result =
          await productRemoteSource.getProduct(productModel.productId);

      expect(result, productModel);
    });

    test('should throw server Exception when the status is 404 or other', () async {

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = productRemoteSource.getProduct(productModel.productId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('getProducts' ,() {

    test('should perform GET with baseURl when remote source getProducts is called', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('products_cached.json'), 200));

      final result = await productRemoteSource.getProducts();

      verify(mockClient.get(
        Uri.parse('$baseUrl'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return List<ProductModel> when the call to remoteSource has a status code of 200', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('products_cached.json'), 200));

      final result = await productRemoteSource.getProducts();

      expect(result, [productModel]);
    });

    test('should throw server Exception when the status is 404 or other', () async {

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = productRemoteSource.getProducts();

      expect(() => call, throwsA(isA<ServerException>()));
    });

  });

  group('createProduct', () {
   
    test('should perform a post request when the remote source create product is called', () async {

      when(mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Created', 201));

      await productRemoteSource.createProduct(productModel);

      verify(mockClient.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(productModel.toJson()),
      ));

    });


    test('should throw server Exception when the status is 404 or other', () async {

      when(mockClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = productRemoteSource.createProduct(productModel);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('deleteProduct', () { 

    test('should perform DELETE when delete product is called on the remote data source', () async {
      
      when(mockClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Deleted', 200));

      await productRemoteSource.deleteProduct(productModel.productId);

      verify(mockClient.delete(
        Uri.parse('$baseUrl/${productModel.productId}'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should throw ServerException when the call to remote server is not successful', () async {
      when(mockClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('something went wrong', 500));

      final call = productRemoteSource.deleteProduct(productModel.productId);

      expect(() => call, throwsA(isA<ServerException>()));


    });

  });

  group('updateProduct', () { 

    test('should perform PATCH when update product is called on the remote data source', () async {
      
      when(mockClient.patch(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Updated', 200));

      await productRemoteSource.updateProduct(productModel);

      verify(mockClient.patch(
        Uri.parse('$baseUrl/${productModel.productId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(productModel.toJson()),
      ));
    });

    test('should throw ServerException when the call to remote server is not successful', () async {
      when(mockClient.patch(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('something went wrong', 500));

      final call = productRemoteSource.updateProduct(productModel);

      expect(() => call, throwsA(isA<ServerException>()));



  });

  });
  

}
