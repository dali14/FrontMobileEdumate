import 'core/network/network_info.dart';
import 'features/product/data/datasources/product_local_data_source.dart';
import 'features/product/data/datasources/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_implement.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/add_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_all_products.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/blocs/add_delete_update_product/add_delete_update_product_bloc.dart';
import 'features/product/presentation/blocs/products/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupProductDI() async {
//! Features - product
// Bloc

  sl.registerFactory(() => ProductsBloc(getAllProducts: sl()));
  sl.registerFactory(() => AddDeleteUpdateProductBloc(
      addProduct: sl(), updateProduct: sl(), deleteProduct: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllProductUsecase(sl()));
  sl.registerLazySingleton(() => AddProductUsecase(sl()));
  sl.registerLazySingleton(() => DeleteProductUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(sl()));

// Repository

  sl.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<ProductRemoteDataSource>(
          () => ProductRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
          () => ProductLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}

