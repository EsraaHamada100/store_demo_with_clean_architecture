import '../entities/category.dart';
import '../repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class UpdateCategoryUseCase {
  final CategoriesRepository repository;
  UpdateCategoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(
    Category category,
    String categorySlugBeforeUpdate,
  ) async {
    return await repository.updateCategory(category, categorySlugBeforeUpdate);
  }
}
