import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category.dart';

abstract class CategoriesRepository{
  Future<Either<Failure, List<Category>>> getAllCategories();
  Future<Either<Failure, Category>> getSingleCategory(String categorySlug);
  Future<Either<Failure, Unit>> addCategory(Category category);
  Future<Either<Failure, Unit>> updateCategory(Category category, String categorySlugBeforeUpdate);
  Future<Either<Failure, Unit>> deleteCategory(String categorySlug);
}