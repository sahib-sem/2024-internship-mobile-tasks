import 'package:bloc_test/bloc_test.dart';
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:clean_arch/features/product/domain/usecases/add_product.dart';
import 'package:clean_arch/features/product/domain/usecases/delete_product.dart';
import 'package:clean_arch/features/product/domain/usecases/filter_product.dart';
import 'package:clean_arch/features/product/domain/usecases/get_product.dart';
import 'package:clean_arch/features/product/domain/usecases/get_product_list.dart';
import 'package:clean_arch/features/product/domain/usecases/update_product.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../../common/test_product_model.dart';
import 'product_bloc_test.mocks.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/blocs.dart';

@GenerateMocks([
  ProductRepository,
])
void main() {
  final createProductUsecase =
      CreateProductUsecase(repository: MockProductRepository());

  final viewAllProductsUsecase = ViewAllProductsUsecase(
    repository: MockProductRepository(),
  );

  final viewProductUsecase = ViewProductUsecase(
    repository: MockProductRepository(),
  );

  final deleteProductUsecase = DeleteProductUsecase(
    repository: MockProductRepository(),
  );

  final updateProductUsecase = UpdateProductUsecase(
    repository: MockProductRepository(),
  );

  final filterProductsUsecase = FilterProductsUsecase(
    repository: MockProductRepository(),
  );

  final products = [testProductModel];
  group('getProducts', () {
    blocTest(
      'should emit ProductLoaded when GetProducts event is added',
      build: () => ProductBloc(
        createProductUsecase: createProductUsecase,
        viewAllProductsUsecase: viewAllProductsUsecase,
        viewProductUsecase: viewProductUsecase,
        deleteProductUsecase: deleteProductUsecase,
        updateProductUsecase: updateProductUsecase,
        filterProductsUsecase: filterProductsUsecase,
      ),
      act: (bloc) => bloc.add(GetProducts()),
      setUp: () {
        when(viewAllProductsUsecase(NoParams()))
            .thenAnswer((_) async => Right(products));
      },
      expect: () => [
        ProductLoading(),
        AllProductLoaded(products),
      ],
    );

    blocTest(
        'should emit ProductError when GetProducts event is added and there is a server failure',
        build: () => ProductBloc(
              createProductUsecase: createProductUsecase,
              viewAllProductsUsecase: viewAllProductsUsecase,
              viewProductUsecase: viewProductUsecase,
              deleteProductUsecase: deleteProductUsecase,
              updateProductUsecase: updateProductUsecase,
              filterProductsUsecase: filterProductsUsecase,
            ),
        setUp: () {
          when(viewAllProductsUsecase(NoParams()))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        act: (bloc) => bloc.add(GetProducts()),
        expect: () => [
              ProductLoading(),
              const ProductError('Server Failure'),
            ]);
  });

  group('getProduct', () {
    blocTest(
      'should emit ProductLoaded when GetProduct event is added',
      build: () => ProductBloc(
        createProductUsecase: createProductUsecase,
        viewAllProductsUsecase: viewAllProductsUsecase,
        viewProductUsecase: viewProductUsecase,
        deleteProductUsecase: deleteProductUsecase,
        updateProductUsecase: updateProductUsecase,
        filterProductsUsecase: filterProductsUsecase,
      ),
      act: (bloc) => bloc.add(const GetProduct('1')),
      setUp: () {
        when(viewProductUsecase(GetProductParams(productId: '1')))
            .thenAnswer((_) async => Right(testProductModel));
      },
      expect: () => [
        ProductLoading(),
        ProductLoaded(testProductModel),
      ],
    );

    blocTest(
        'should emit ProductError when GetProduct event is added and there is a server failure',
        build: () => ProductBloc(
              createProductUsecase: createProductUsecase,
              viewAllProductsUsecase: viewAllProductsUsecase,
              viewProductUsecase: viewProductUsecase,
              deleteProductUsecase: deleteProductUsecase,
              updateProductUsecase: updateProductUsecase,
              filterProductsUsecase: filterProductsUsecase,
            ),
        setUp: () {
          when(viewProductUsecase(GetProductParams(productId: '1')))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        act: (bloc) => bloc.add(const GetProduct('1')),
        expect: () => [
              ProductLoading(),
              const ProductError('Server Failure'),
            ]);
  });

  group('createProduct', () {
    blocTest(
      'should emit AllProductLoaded when CreateProduct event is added',
      build: () => ProductBloc(
        createProductUsecase: createProductUsecase,
        viewAllProductsUsecase: viewAllProductsUsecase,
        viewProductUsecase: viewProductUsecase,
        deleteProductUsecase: deleteProductUsecase,
        updateProductUsecase: updateProductUsecase,
        filterProductsUsecase: filterProductsUsecase,
      ),
      act: (bloc) => bloc.add(CreateProduct(testProductModel)),
      setUp: () {
        when(createProductUsecase(AddProductParams(product: testProductModel)))
            .thenAnswer((_) async => Right(null));
      },
      expect: () => [
        ProductLoading(),
        const AllProductLoaded([]),
      ],
    );

    blocTest(
        'should emit ProductError when CreateProduct event is added and there is a server failure',
        build: () => ProductBloc(
              createProductUsecase: createProductUsecase,
              viewAllProductsUsecase: viewAllProductsUsecase,
              viewProductUsecase: viewProductUsecase,
              deleteProductUsecase: deleteProductUsecase,
              updateProductUsecase: updateProductUsecase,
              filterProductsUsecase: filterProductsUsecase,
            ),
        setUp: () {
          when(createProductUsecase(AddProductParams(product: testProductModel)))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        act: (bloc) => bloc.add(CreateProduct(testProductModel)),
        expect: () => [
              ProductLoading(),
              const ProductError('Server Failure'),
            ]);
  });

  group('updateProduct', () {
    blocTest(
      'should emit AllProductLoaded when UpdateProduct event is added',
      build: () => ProductBloc(
        createProductUsecase: createProductUsecase,
        viewAllProductsUsecase: viewAllProductsUsecase,
        viewProductUsecase: viewProductUsecase,
        deleteProductUsecase: deleteProductUsecase,
        updateProductUsecase: updateProductUsecase,
        filterProductsUsecase: filterProductsUsecase
      ),
      act: (bloc) => bloc.add(UpdateProduct(testProductModel)),
      setUp: () {
        when(updateProductUsecase(UpdateProductParams(product: testProductModel)))
            .thenAnswer((_) async => Right(null));
      },
      expect: () => [
        ProductLoading(),
        const AllProductLoaded([]),
      ],
    );

    blocTest(
        'should emit ProductError when UpdateProduct event is added and there is a server failure',
        build: () => ProductBloc(
              createProductUsecase: createProductUsecase,
              viewAllProductsUsecase: viewAllProductsUsecase,
              viewProductUsecase: viewProductUsecase,
              deleteProductUsecase: deleteProductUsecase,
              filterProductsUsecase: filterProductsUsecase,
              updateProductUsecase: updateProductUsecase,
            ),
        setUp: () {
          when(updateProductUsecase(UpdateProductParams(product: testProductModel)))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        act: (bloc) => bloc.add(UpdateProduct(testProductModel)),
        expect: () => [
              ProductLoading(),
              const ProductError('Server Failure'),
            ]);
  });

  group('deleteProduct', () {
    blocTest(
      'should emit AllProductLoaded when DeleteProduct event is added',
      build: () => ProductBloc(
        createProductUsecase: createProductUsecase,
        viewAllProductsUsecase: viewAllProductsUsecase,
        viewProductUsecase: viewProductUsecase,
        deleteProductUsecase: deleteProductUsecase,
        updateProductUsecase: updateProductUsecase,
        filterProductsUsecase: filterProductsUsecase
      ),
      act: (bloc) => bloc.add(DeleteProduct('1')),
      setUp: () {
        when(deleteProductUsecase(DeleteProductParams(productId: '1')))
            .thenAnswer((_) async => Right(null));
      },
      expect: () => [
        ProductLoading(),
        const AllProductLoaded([]),
      ],
    );

    blocTest(
        'should emit ProductError when DeleteProduct event is added and there is a server failure',
        build: () => ProductBloc(
              createProductUsecase: createProductUsecase,
              viewAllProductsUsecase: viewAllProductsUsecase,
              viewProductUsecase: viewProductUsecase,
              deleteProductUsecase: deleteProductUsecase,
              updateProductUsecase: updateProductUsecase,
              filterProductsUsecase: filterProductsUsecase
            ),
        setUp: () {
          when(deleteProductUsecase(DeleteProductParams(productId: '1')))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        act: (bloc) => bloc.add(DeleteProduct('1')),
        expect: () => [
              ProductLoading(),
              const ProductError('Server Failure'),
            ]);
  });
}
