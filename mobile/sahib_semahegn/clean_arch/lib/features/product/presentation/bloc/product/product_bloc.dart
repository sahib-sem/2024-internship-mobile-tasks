import 'package:clean_arch/core/usecases/usecase.dart';
import 'package:clean_arch/features/product/domain/usecases/add_product.dart';
import 'package:clean_arch/features/product/domain/usecases/delete_product.dart';
import 'package:clean_arch/features/product/domain/usecases/get_product.dart';
import 'package:clean_arch/features/product/domain/usecases/get_product_list.dart';
import 'package:clean_arch/features/product/domain/usecases/update_product.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/product_events.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CreateProductUsecase createProductUsecase;
  final ViewAllProductsUsecase viewAllProductsUsecase;
  final ViewProductUsecase viewProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  final UpdateProductUsecase updateProductUsecase;

  ProductBloc({
    required this.createProductUsecase,
    required this.viewAllProductsUsecase,
    required this.viewProductUsecase,
    required this.deleteProductUsecase,
    required this.updateProductUsecase,
  }) : super(ProductInitial()) {
    on<GetProducts>((event, emit) async {
      emit(ProductLoading());
      final result = await viewAllProductsUsecase(NoParams());
      result.fold(
        (failure) => emit(const ProductError(SERVER_FAILURE_MESSAGE)),
        (products) => emit(AllProductLoaded(products)),
      );
    });

    on<GetProduct>((event, emit) async {
      emit(ProductLoading());
      final result =
          await viewProductUsecase(GetProductParams(productId: event.id));
      result.fold(
        (failure) => emit(const ProductError(SERVER_FAILURE_MESSAGE)),
        (product) => emit(ProductLoaded(product)),
      );
    });

    on<CreateProduct>((event, emit) async {
      emit(ProductLoading());
      final result = await createProductUsecase(AddProductParams(
        product: event.product,
        image: event.image,
      ));
      result.fold(
        (failure) => emit(const ProductError(SERVER_FAILURE_MESSAGE)),
        (product) => emit(const AllProductLoaded([])),
      );

      final updatedProducts = await viewAllProductsUsecase(NoParams());
      updatedProducts.fold(
        (failure) => emit(const ProductError(SERVER_FAILURE_MESSAGE)),
        (products) => emit(AllProductLoaded(products)),
      );
    });

    on<UpdateProduct>((event, emit) async {
      emit(ProductLoading());
      final result = await updateProductUsecase(
          UpdateProductParams(product: event.product));
      result.fold(
        (failure) => emit(const ProductError(SERVER_FAILURE_MESSAGE)),
        (product) => emit(const AllProductLoaded([])),
      );

      final updatedProducts = await viewAllProductsUsecase(NoParams());
      updatedProducts.fold(
        (failure) => emit(const ProductError(SERVER_FAILURE_MESSAGE)),
        (products) => emit(AllProductLoaded(products)),
      );
    });

    on<DeleteProduct>((event, emit) async {
      emit(ProductLoading());
      final result =
          await deleteProductUsecase(DeleteProductParams(productId: event.id));
      result.fold(
        (failure) => emit(const ProductError(SERVER_FAILURE_MESSAGE)),
        (product) => emit(const AllProductLoaded([])),
      );

      final updatedProducts = await viewAllProductsUsecase(NoParams());
      updatedProducts.fold(
        (failure) => emit(const ProductError(SERVER_FAILURE_MESSAGE)),
        (products) => emit(AllProductLoaded(products)),
      );
    });
  }
}
