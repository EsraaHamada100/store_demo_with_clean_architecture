part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class LoadingCategoriesState extends CategoriesState {}

class LoadedCategoriesState extends CategoriesState {
  final List<Category> categoriesList;
  const LoadedCategoriesState({required this.categoriesList});
  @override
  List<Object> get props => [categoriesList];
}

class GetSingleCategoryState extends CategoriesState {
  final Category category;
  const GetSingleCategoryState({required this.category});
  @override
  List<Object> get props => [category];
}

class ErrorCategoriesState extends CategoriesState {
  final String message;
  const ErrorCategoriesState({required this.message});
}
