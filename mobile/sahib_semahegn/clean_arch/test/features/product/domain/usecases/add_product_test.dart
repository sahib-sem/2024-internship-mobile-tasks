import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:clean_arch/features/product/domain/usecases/add_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/test_product.dart';
import '../../../../common/test_product_model.dart';
import 'add_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  test('should return void when product is being added', () async {
    MockProductRepository mockProductRepository = MockProductRepository();
    CreateProductUsecase usecase =
        CreateProductUsecase(repository: mockProductRepository);

    when(mockProductRepository.createProdut(testProductModel))
        .thenAnswer((_) async => const Right(null));

    final result = await usecase(AddProductParams(product: testProductModel));

    expect(result, const Right(null));
    verify(mockProductRepository.createProdut(testProductModel));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
