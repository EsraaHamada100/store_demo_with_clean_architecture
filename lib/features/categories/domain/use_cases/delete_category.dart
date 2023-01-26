import '../repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
class DeleteCategoryUseCase {
  final CategoriesRepository repository;
  DeleteCategoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(String categorySlug)async{
    return await repository.deleteCategory(categorySlug);
  }
 }
