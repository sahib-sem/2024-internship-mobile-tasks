import 'package:collection/collection.dart';
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/entities/product.dart';
import 'package:clean_arch/features/product/domain/usecases/get_product_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/test_product.dart';
import 'add_product_test.mocks.dart';

void main() {

  test('should return list of products', () async {
    MockProductRepository mockProductRepository = MockProductRepository();
    GetProductList usecase = GetProductList(repository: mockProductRepository);

    when(mockProductRepository.getProducts())
      .thenAnswer((_) async => Right([testProduct]));

    
    verifyNoMoreInteractions(mockProductRepository);
  });
}
