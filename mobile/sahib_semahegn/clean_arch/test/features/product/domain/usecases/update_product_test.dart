import 'package:clean_arch/features/product/domain/usecases/update_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/test_product_model.dart';
import 'add_product_test.mocks.dart';

void main() {
  test('should return void when a product is updated', () async {
    MockProductRepository mockProductRepository = MockProductRepository();
    UpdateProductUsecase usecase =
        UpdateProductUsecase(repository: mockProductRepository);
    

    when(mockProductRepository.updateProduct(testProductModel)).thenAnswer((_) async => Right(null));

    final result = await usecase(UpdateProductParams(product: testProductModel));

    expect(result, const Right(null));
    verify(mockProductRepository.updateProduct(testProductModel));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
