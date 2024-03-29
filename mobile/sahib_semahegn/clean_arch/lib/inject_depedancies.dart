import 'dart:async';

import 'package:clean_arch/core/network/network_info.dart';
import 'package:clean_arch/features/product/data/datasources/product_local_datasource.dart';
import 'package:clean_arch/features/product/data/datasources/product_remote_source.dart';
import 'package:clean_arch/features/product/data/repositories/product_repositories_implementation.dart';
import 'package:clean_arch/features/product/domain/repositories/product_repository.dart';
import 'package:clean_arch/features/product/domain/usecases/add_product.dart';
import 'package:clean_arch/features/product/domain/usecases/delete_product.dart';
import 'package:clean_arch/features/product/domain/usecases/get_product.dart';
import 'package:clean_arch/features/product/domain/usecases/get_product_list.dart';
import 'package:clean_arch/features/product/domain/usecases/update_product.dart';
import 'package:clean_arch/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //******* features  */

  // bloc

  sl.registerFactory(() => ProductBloc(
        createProductUsecase: sl(),
        viewAllProductsUsecase: sl(),
        viewProductUsecase: sl(),
        deleteProductUsecase: sl(),
        updateProductUsecase: sl(),
      ));

  // usecases
  sl.registerLazySingleton(() => CreateProductUsecase(repository: sl()));
  sl.registerLazySingleton(() => ViewAllProductsUsecase(repository: sl()));
  sl.registerLazySingleton(() => ViewProductUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(repository: sl()));

  // repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        productLocalSource: sl(),
        productRemoteSource: sl(),
        networkInfo: sl(),
      ));

  // data sources
  sl.registerLazySingleton<ProductLocalSource>(() => ProductLocalSourceImpl(
        dataSource: sl(),
      ));
  sl.registerLazySingleton<ProductRemoteSource>(() => ProductRemoteSourceImpl(
        client: sl(),
      ));


  //******* core */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //******* external */

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
