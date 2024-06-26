import 'package:clean_arch/features/product/domain/usecases/delete_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'add_product_test.mocks.dart';

void main() {
  test('should return null when product is deleted', () async {
    MockProductRepository mockProductRepository = MockProductRepository();
    DeleteProductUsecase usecase =
        DeleteProductUsecase(repository: mockProductRepository);
    String productId = '123asdfjlkj';

    when(mockProductRepository.deleteProduct(productId))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(DeleteProductParams(productId: productId));

    expect(result, const Right(null));
    verify(mockProductRepository.deleteProduct(productId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
