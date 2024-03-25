

import 'dart:convert';

import 'package:clean_arch/features/product/data/datasources/product_local_datasource.dart';
import 'package:clean_arch/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixture/fixture.dart';
import 'local_datasource_implementation_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {

  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  ProductLocalSourceImpl productLocalSource = ProductLocalSourceImpl(dataSource: mockSharedPreferences);


  group('get cached products', () { 

    final productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));

    test('should return product list from shared preferences', () async {

      when(mockSharedPreferences.getString(any)).thenReturn(fixture('products_cached.json'));

      final result = await productLocalSource.getLatestCachedProducts();

      expect(result, [productModel]);
      verify(mockSharedPreferences.getString('CACHED_PRODUCTS'));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw exception when there is no cached products', () async {

      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = productLocalSource.getLatestCachedProducts;

      expect(() => call(), throwsA(isA<Exception>()));
      verify(mockSharedPreferences.getString('CACHED_PRODUCTS'));
      verifyNoMoreInteractions(mockSharedPreferences);
    });

  });

  group('cacheProducts', () { 

    final productModel = ProductModel.fromJson(jsonDecode(fixture('product.json')));

    test('should cache products in shared preferences', () async {

      when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
      final List<ProductModel> products = [productModel];

      productLocalSource.cacheProducts(products);

      final expectedJsonString = jsonEncode({'products': [productModel.toJson()]});

      verify(mockSharedPreferences.setString('CACHED_PRODUCTS', expectedJsonString));
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });


}