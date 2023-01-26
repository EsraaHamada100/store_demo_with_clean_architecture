import '../../../../core/error/exceptions.dart';
import '../../../../core/strings/failure_strings.dart';
import '../models/product_model.dart';
import '../../Domain/entities/product.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../Domain/repositories/products_repository.dart';

import '../../../../core/network/network_info.dart';
import '../../../../core/util/repo_util.dart';
import '../date_sources/products_local_data_source.dart';
import '../date_sources/products_remote_data_source.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      return await _getDataFromAPI();
    } else {
      return await _getDataFromCache();
    }
  }

  @override
  Future<Either<Failure, Product>> getSingleProduct(String productSlug) async {
    if (await networkInfo.isConnected) {
      return await _getSingleProductFromAPI(productSlug);
    } else {
      return await _getSingleProductFromCache(productSlug);
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(Product product) {
    return RepositoriesUtil.getMessage(
      deleteOrUpdateOrAddFunction: () =>
          remoteDataSource.addProduct(product as ProductModel),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String productSlug) {
    return RepositoriesUtil.getMessage(
      deleteOrUpdateOrAddFunction: () =>
          remoteDataSource.deleteProduct(productSlug),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(
      Product product, String productSlugBeforeUpdate) {
    return RepositoriesUtil.getMessage(
      deleteOrUpdateOrAddFunction: () => remoteDataSource.updateProduct(
        product as ProductModel,
        productSlugBeforeUpdate,
      ),
      networkInfo: networkInfo,
    );
  }

  Future<Either<Failure, List<Product>>> _getDataFromCache() async {
    try {
      final List<Product> localProducts =
          await localDataSource.getCachedProducts();

      return Right(localProducts);
    } on EmptyCacheException {
      return const Left(EmptyCacheFailure());
    }
  }

  Future<Either<Failure, List<Product>>> _getDataFromAPI() async {
    try {
      final remoteProducts = await remoteDataSource.getAllProducts();
      localDataSource.cacheProducts(remoteProducts);
      return Right(remoteProducts);
    } on ServerException {
      return const Left(ServerFailure());
    } on NoInternetException {
      return const Left(NoInternetFailure());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  Future<Either<Failure, Product>> _getSingleProductFromAPI(
      String productSlug) async {
    try {
      final remoteProduct =
          await remoteDataSource.getSingleProduct(productSlug);
      return Right(remoteProduct);
    } on ServerException {
      return const Left(ServerFailure());
    } on NoInternetException {
      return const Left(NoInternetFailure());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  Future<Left<Failure, Product>> _getSingleProductFromCache(
      String productSlug) async {
    final localProductsOrFailure = await _getDataFromCache();
    localProductsOrFailure.fold((failure) {
      return failure;
    }, (localProducts) {
      localProducts.map((product) {
        if (product.slug == productSlug) {
          return Right(product);
        }
      });
    });
    return const Left(NotFoundFailure(PRODUCT_NOT_FOUND_MESSAGE));
  }
}
