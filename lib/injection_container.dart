import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/network/network_info.dart';
import 'core/strings/local_db_strings.dart';
import 'features/categories/data/data_sources/categories_local_data_source.dart';
import 'features/categories/data/data_sources/categories_remote_data_source.dart';
import 'features/categories/data/repositories/categories_repository_impl.dart';
import 'features/categories/domain/repositories/categories_repository.dart';
import 'features/categories/domain/use_cases/get_all_categories.dart';
import 'features/categories/domain/use_cases/get_single_category.dart';
import 'features/categories/domain/use_cases/update_categories.dart';
import 'features/categories/presentation/bloc/categories_bloc/categories_bloc.dart';
import 'features/products/Data/date_sources/products_local_data_source.dart';
import 'features/products/Data/date_sources/products_remote_data_source.dart';
import 'features/products/Data/repositories/products_repository_impl.dart';
import 'features/products/Domain/repositories/products_repository.dart';
import 'features/products/Domain/user_cases/add_product.dart';
import 'features/products/Domain/user_cases/delete_product.dart';
import 'features/products/Domain/user_cases/get_all_products.dart';
import 'features/products/Domain/user_cases/get_single_product.dart';
import 'features/products/Domain/user_cases/update_product.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/products/Presentation/Bloc/products_bloc/products_bloc.dart';
import 'features/categories/domain/entities/category.dart';
import 'features/categories/domain/use_cases/add_category.dart';
import 'features/categories/domain/use_cases/delete_category.dart';
import 'features/products/Domain/entities/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

final GetIt getIt = GetIt.instance;
Future<void> init() async {
  //! External
  /* internet_connection_checker */
  if (!kIsWeb) {
    final InternetConnectionChecker internetConnectionChecker =
        InternetConnectionChecker.createInstance();
    getIt.registerLazySingleton(() => internetConnectionChecker);
  }

  /* connectivity package to make it work in web */
  final Connectivity connectivity = Connectivity();

  /* Hive */
  // String path = Directory.current.path;
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive..registerAdapter(ProductAdapter())..registerAdapter(ProductCategoryAdapter())..registerAdapter(CreatedByAdapter());
  await Hive.openBox<Product>(PRODUCT_BOX_NAME);
  final Box<Product> productsBox = Hive.box<Product>(PRODUCT_BOX_NAME);

  await Hive.openBox<Category>(CATEGORY_BOX_NAME);
  final Box<Category> categoriesBox = Hive.box<Category>(CATEGORY_BOX_NAME);

  getIt.registerLazySingleton(() => connectivity);
  getIt.registerLazySingleton(() => productsBox);
  getIt.registerLazySingleton(() => categoriesBox);
  getIt.registerLazySingleton(() => http.Client());

  //! core

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: !kIsWeb ? getIt<InternetConnectionChecker>() : null,
      connectivity: getIt<Connectivity>(),
    ),
  );

  //! Data sources

  /* products */

  getIt.registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(client: getIt<Client>()));

  getIt.registerLazySingleton<ProductsLocalDataSource>(
      () => ProductsLocalImplWithHive(productsBox: getIt<Box<Product>>()));

  /* categories */

  getIt.registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImpl(client: getIt<Client>()));

  getIt.registerLazySingleton<CategoriesLocalDataSource>(
      () => CategoriesLocalImpWithHive(categoriesBox: getIt<Box<Category>>()));

  //! repositories

  /* products */

  getIt.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(
        remoteDataSource: getIt<ProductsRemoteDataSource>(),
        localDataSource: getIt<ProductsLocalDataSource>(),
        networkInfo: getIt<NetworkInfo>(),
      ));

  /* categories */

  getIt.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(
            remoteDataSource: getIt<CategoriesRemoteDataSource>(),
            localDataSource: getIt<CategoriesLocalDataSource>(),
            networkInfo: getIt<NetworkInfo>(),
          ));

  //! use cases

  /* products */

  getIt.registerLazySingleton(
      () => GetAllProductsUseCase(getIt<ProductsRepository>()));
  getIt.registerLazySingleton(
      () => GetSingleProductUseCase(getIt<ProductsRepository>()));
  getIt.registerLazySingleton(
      () => AddProductUseCase(getIt<ProductsRepository>()));
  getIt.registerLazySingleton(
      () => UpdateProductUseCase(getIt<ProductsRepository>()));
  getIt.registerLazySingleton(
      () => DeleteProductUseCase(getIt<ProductsRepository>()));

  /* categories */

  getIt.registerLazySingleton(
      () => GetAllCategoriesUseCase(repository: getIt<CategoriesRepository>()));
  getIt.registerLazySingleton(() =>
      GetSingleCategoryUseCase(repository: getIt<CategoriesRepository>()));
  getIt.registerLazySingleton(
      () => AddCategoryUseCase(repository: getIt<CategoriesRepository>()));
  getIt.registerLazySingleton(
      () => UpdateCategoryUseCase(repository: getIt<CategoriesRepository>()));
  getIt.registerLazySingleton(
      () => DeleteCategoryUseCase(repository: getIt<CategoriesRepository>()));

  //! Blocs

  /* products */

  getIt.registerFactory(
    () => ProductsBloc(
      getAllProductsUseCase: getIt<GetAllProductsUseCase>(),
      getSingleProductUseCase: getIt<GetSingleProductUseCase>(),
    ),
  );

  /* categories */

  getIt.registerFactory(
    () => CategoriesBloc(
      getAllCategoriesUseCase: getIt<GetAllCategoriesUseCase>(),
      getSingleCategoryUseCase: getIt<GetSingleCategoryUseCase>(),
    ),
  );
}

