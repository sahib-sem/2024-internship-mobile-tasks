import 'package:clean_arch/features/product/domain/usecases/get_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/test_product.dart';
import 'add_product_test.mocks.dart';

void main() {
  test('should return a product when a productId is provided', () async {
    MockProductRepository mockProductRepository = MockProductRepository();
    ViewProductUsecase usecase = ViewProductUsecase(repository: mockProductRepository);
    String productId = '123asdfjlkj';

    when(mockProductRepository.getProduct(productId))
        .thenAnswer((_) async => Right(testProduct));

    final result = await usecase(GetProductParams(productId: productId));

    expect(result, Right(testProduct));
    verify(mockProductRepository.getProduct(productId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
