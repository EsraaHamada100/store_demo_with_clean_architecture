import '../entities/category.dart';
import '../repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
class AddCategoryUseCase {
  final CategoriesRepository repository;
  AddCategoryUseCase({required this.repository});

  Future<Either<Failure, Unit>> call(Category category)async{
    return await repository.addCategory(category);
  }
 }
