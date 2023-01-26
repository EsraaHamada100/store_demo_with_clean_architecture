import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../models/category.dart';
import '../../domain/entities/category.dart';

abstract class CategoriesLocalDataSource {
  Future<List<CategoryModel>> getCachedCategories();
  Future<Unit> cacheCategories(List<CategoryModel> categoryModels);
}

class CategoriesLocalImpWithHive implements CategoriesLocalDataSource {
  final Box<Category> categoriesBox;
  CategoriesLocalImpWithHive({required this.categoriesBox});
  @override
  Future<Unit> cacheCategories(List<CategoryModel> categoryModels) {
    categoriesBox.clear();
    categoryModels.map((category) => categoriesBox.add(category));
    categoriesBox.close();
    return Future.value(unit);
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() {
    final List<CategoryModel> categoriesList = categoriesBox.values.toList().cast<CategoryModel>();
    if (categoriesList.isNotEmpty) {
      return Future.value(categoriesList);
    } else {
      throw EmptyCacheException();
    }
  }
}
