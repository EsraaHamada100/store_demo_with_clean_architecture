import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/failure_strings.dart';
import '../../../../core/util/repo_util.dart';
import '../data_sources/categories_local_data_source.dart';
import '../data_sources/categories_remote_data_source.dart';
import '../models/category.dart';
import '../../domain/entities/category.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  CategoriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    if (await networkInfo.isConnected) {
      return await _getDataFromAPI();
    } else {
      return await _getDataFromCache();
    }
  }

  @override
  Future<Either<Failure, Category>> getSingleCategory(
      String categorySlug) async {
    if (await networkInfo.isConnected) {
      return await _getSingleCategoryFromAPI(categorySlug);
    } else {
      return await _getSingleCategoryFromCache(categorySlug);
    }
  }

  Future<Left<Failure, Category>> _getSingleCategoryFromCache(
      String categorySlug) async {
    final localCategoriesOrFailure = await _getDataFromCache();
    localCategoriesOrFailure.fold(
      (failure) => failure,
      (categories) {
        categories.map(
          (category) {
            if (category.slug == categorySlug) return Right(category);
          },
        );
      },
    );
    return const Left(NotFoundFailure(CATEGORY_NOT_FOUND_MESSAGE));
  }

  Future<Either<Failure, Category>> _getSingleCategoryFromAPI(
      String categorySlug) async {
    try {
      final remoteCategory =
          await remoteDataSource.getSingleCategory(categorySlug);
      return Right(remoteCategory);
    } on ServerException {
      return const Left(ServerFailure());
    } on NoInternetException {
      return const Left(NoInternetFailure());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> addCategory(Category category) {
    return RepositoriesUtil.getMessage(
      deleteOrUpdateOrAddFunction: () =>
          remoteDataSource.addCategory(category as CategoryModel),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(String categorySlug) {
    return RepositoriesUtil.getMessage(
      deleteOrUpdateOrAddFunction: () =>
          remoteDataSource.deleteCategory(categorySlug),
      networkInfo: networkInfo,
    );
  }

  @override
  Future<Either<Failure, Unit>> updateCategory(
      Category category, String categorySlugBeforeUpdate) {
    return RepositoriesUtil.getMessage(
      deleteOrUpdateOrAddFunction: () => remoteDataSource.updateCategory(
          category as CategoryModel, categorySlugBeforeUpdate),
      networkInfo: networkInfo,
    );
  }

  Future<Either<Failure, List<Category>>> _getDataFromAPI() async {
    try {
      final remoteCategories = await remoteDataSource.getAllCategories();
      localDataSource.cacheCategories(remoteCategories);
      return Right(remoteCategories);
    } on ServerException {
      return const Left(ServerFailure());
    } on NoInternetException {
      return const Left(NoInternetFailure());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  Future<Either<Failure, List<Category>>> _getDataFromCache() async {
    try {
      final localCategories = await localDataSource.getCachedCategories();
      return Right(localCategories);
    } on EmptyCacheException {
      return const Left(EmptyCacheFailure());
    }
  }
}
