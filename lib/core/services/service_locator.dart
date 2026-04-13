import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:mytasks/features/cart/presentation/bloc/cart%20bloc.dart';
import 'package:mytasks/features/products/data/datasources/ProductRemoteDataSource.dart';
import 'package:mytasks/features/products/data/repositories/ProductRepositoryImpl.dart';
import 'package:mytasks/features/products/domain/repositories/ProductRepository.dart';
import 'package:mytasks/features/products/domain/usecases/GetProductsUseCase.dart';
import 'package:mytasks/features/products/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {



  sl.registerFactory(() => ProductBloc(getProductsUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );

sl.registerFactory(() => CartBloc());
  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  // Dio with configuration
  sl.registerLazySingleton(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        contentType: Headers.jsonContentType,
      ),
    );
    return dio;
  });
}