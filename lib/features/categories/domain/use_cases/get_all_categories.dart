import '../entities/category.dart';
import '../repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
class GetAllCategoriesUseCase {
  final CategoriesRepository repository;
  GetAllCategoriesUseCase({required this.repository});

  Future<Either<Failure, List<Category>>> call()async{
    return await repository.getAllCategories();
  }
 }
