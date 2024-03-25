import 'package:clean_arch/core/error/exception.dart' as custom_exceptions;
import 'package:clean_arch/core/error/failure.dart';
import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/product/data/datasources/product_local_datasource.dart';
import 'package:clean_arch/features/product/data/datasources/product_remote_source.dart';
import 'package:clean_arch/features/product/data/repositories/product_repositories_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../common/test_product_model.dart';
import 'product_repository_implementation_test.mocks.dart';

@GenerateMocks([NetworkInfo, ProductRemoteSource, ProductLocalSource])
void main() {
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  MockProductRemoteSource mockProductRemoteSource = MockProductRemoteSource();
  MockProductLocalSource mockProductLocalSource = MockProductLocalSource();

  final productRepository = ProductRepositoryImpl(
      networkInfo: mockNetworkInfo,
      productLocalSource: mockProductLocalSource,
      productRemoteSource: mockProductRemoteSource);

  group('createProduct', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return Right(null) when the call to remote data source is successful',
          () async {
        // arrange

        when(mockProductRemoteSource.createProduct(testProductModel))
            .thenAnswer((_) async => const Right(null));
        // act
        final result = await productRepository.createProdut(testProductModel);
        // assert
        expect(result, const Right(null));
        verify(mockProductRemoteSource.createProduct(testProductModel));
        verifyNoMoreInteractions(mockProductRemoteSource);
      });

      test(
          'should return ServerFailure when the call to the remote data source is unsuccessful',
          () async {
        // arrange
        when(mockProductRemoteSource.createProduct(testProductModel))
            .thenThrow(custom_exceptions.ServerException());
        // act
        final result = await productRepository.createProdut(testProductModel);
        // assert
        expect(result, Left(ServerFailure()));
        verify(mockProductRemoteSource.createProduct(testProductModel));
        verifyNoMoreInteractions(mockProductRemoteSource);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return NetworkFailure when the device is offline', () async {
        final result = await productRepository.createProdut(testProductModel);
        // assert
        expect(result, Left(NetworkFailure()));
      });
    });
  });

  group('delete product', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return Right(null) when the call to remote data source is successful',
          () async {
        // arrange

        when(mockProductRemoteSource.deleteProduct(testProductModel.productId))
            .thenAnswer((_) async => const Right(null));
        // act
        final result =
            await productRepository.deleteProduct(testProductModel.productId);
        // assert
        expect(result, const Right(null));
        verify(
            mockProductRemoteSource.deleteProduct(testProductModel.productId));
        verifyNoMoreInteractions(mockProductRemoteSource);
      });

      test(
          'should return ServerFailure when the call to the remote data source is unsuccessful',
          () async {
        // arrange
        when(mockProductRemoteSource.deleteProduct(testProductModel.productId))
            .thenThrow(custom_exceptions.ServerException());
        // act
        final result =
            await productRepository.deleteProduct(testProductModel.productId);
        // assert
        expect(result, Left(ServerFailure()));
        verify(
            mockProductRemoteSource.deleteProduct(testProductModel.productId));
        verifyNoMoreInteractions(mockProductRemoteSource);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return NetworkFailure when the device is offline', () async {
        final result =
            await productRepository.deleteProduct(testProductModel.productId);
        // assert
        expect(result, Left(NetworkFailure()));
      });
    });
  });

  group('getProduct', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return Right(Product) when the call to remote data source is successful',
          () async {
        // arrange

        when(mockProductRemoteSource.getProduct(testProductModel.productId))
            .thenAnswer((_) async => testProductModel);
        // act
        final result =
            await productRepository.getProduct(testProductModel.productId);
        // assert
        expect(result, Right(testProductModel));
        verify(mockProductRemoteSource.getProduct(testProductModel.productId));
        verifyNoMoreInteractions(mockProductRemoteSource);
      });

      test(
          'should return ServerFailure when the call to the remote data source is unsuccessful',
          () async {
        // arrange
        when(mockProductRemoteSource.getProduct(testProductModel.productId))
            .thenThrow(custom_exceptions.ServerException());
        // act
        final result =
            await productRepository.getProduct(testProductModel.productId);
        // assert
        expect(result, Left(ServerFailure()));
        verify(mockProductRemoteSource.getProduct(testProductModel.productId));
        verifyNoMoreInteractions(mockProductRemoteSource);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return NetworkFailure when the device is offline', () async {
        final result =
            await productRepository.getProduct(testProductModel.productId);
        // assert
        expect(result, Left(NetworkFailure()));
      });
    });
  });

  group('getProducts', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return Right(List<Product>) when the call to remote data source is successful',
          () async {
        // arrange

        when(mockProductRemoteSource.getProducts())
            .thenAnswer((_) async => [testProductModel]);
        // act
        final result = await productRepository.getProducts();
        // assert
        expect(result, Right([testProductModel]));
        verify(mockProductRemoteSource.getProducts());
        verifyNoMoreInteractions(mockProductRemoteSource);
      });

      test(
          'should return ServerFailure when the call to the remote data source is unsuccessful',
          () async {
        // arrange
        when(mockProductRemoteSource.getProducts())
            .thenThrow(custom_exceptions.ServerException());
        // act
        final result = await productRepository.getProducts();
        // assert
        expect(result, Left(ServerFailure()));
        verify(mockProductRemoteSource.getProducts());
        verifyNoMoreInteractions(mockProductRemoteSource);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return cached data when the call to the local source is sucessful',
          () async {
        when(mockProductLocalSource.getLatestCachedProducts())
            .thenAnswer((_) async => [testProductModel]);
        // act
        final result = await productRepository.getProducts();
        // assert
        expect(result, Right([testProductModel]));
        verify(mockProductLocalSource.getLatestCachedProducts());
        verifyNoMoreInteractions(mockProductLocalSource);
      });

      test(
          'should return CacheFailure when the call to the local source is unsuccessful',
          () async {
        // arrange
        when(mockProductLocalSource.getLatestCachedProducts())
            .thenThrow(custom_exceptions.CacheException());
        // act
        final result = await productRepository.getProducts();
        // assert
        expect(result, Left(CacheFailure()));
        verify(mockProductLocalSource.getLatestCachedProducts());
        verifyNoMoreInteractions(mockProductLocalSource);
      });
    });
  });

  group('updateProduct', () {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'should return Right(null) when the call to remote data source is successful',
          () async {
        // arrange

        when(mockProductRemoteSource.updateProduct(testProductModel))
            .thenAnswer((_) async => const Right(null));
        // act
        final result = await productRepository.updateProduct(testProductModel);
        // assert
        expect(result, const Right(null));
        verify(mockProductRemoteSource.updateProduct(testProductModel));
        verifyNoMoreInteractions(mockProductRemoteSource);
      });

      test(
          'should return ServerFailure when the call to the remote data source is unsuccessful',
          () async {
        // arrange
        when(mockProductRemoteSource.updateProduct(testProductModel))
            .thenThrow(custom_exceptions.ServerException());
        // act
        final result = await productRepository.updateProduct(testProductModel);
        // assert
        expect(result, Left(ServerFailure()));
        verify(mockProductRemoteSource.updateProduct(testProductModel));
        verifyNoMoreInteractions(mockProductRemoteSource);
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return NetworkFailure when the device is offline', () async {
        final result = await productRepository.updateProduct(testProductModel);
        // assert
        expect(result, Left(NetworkFailure()));
      });
    });
  });

}
