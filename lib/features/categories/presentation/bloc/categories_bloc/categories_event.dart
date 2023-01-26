part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategoriesEvent extends CategoriesEvent {}

class RefreshCategoriesEvent extends CategoriesEvent {}

class GetSingleCategoryEvent extends CategoriesEvent {
  final String categorySlug;
  const GetSingleCategoryEvent({required this.categorySlug});
    @override
  List<Object> get props => [categorySlug];
}
