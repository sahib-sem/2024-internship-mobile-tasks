import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/test_product.dart';
import 'add_product_test.mocks.dart';

void main() {
  test('should return list of products', () async {
    MockProductRepository mockProductRepository = MockProductRepository();

    when(mockProductRepository.getProducts())
        .thenAnswer((_) async => Right([testProduct]));

    verifyNoMoreInteractions(mockProductRepository);
  });
}
