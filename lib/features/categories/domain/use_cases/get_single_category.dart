import '../entities/category.dart';
import '../repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
class GetSingleCategoryUseCase {
  final CategoriesRepository repository;
  GetSingleCategoryUseCase({required this.repository});

  Future<Either<Failure, Category>> call(String categorySlug)async{
    return await repository.getSingleCategory(categorySlug);
  }
 }
