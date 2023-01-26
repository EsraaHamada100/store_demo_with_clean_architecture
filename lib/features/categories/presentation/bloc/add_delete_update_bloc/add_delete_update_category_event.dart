part of 'add_delete_update_category_bloc.dart';

abstract class AddDeleteUpdateCategoryEvent extends Equatable {
  const AddDeleteUpdateCategoryEvent();

  @override
  List<Object> get props => [];
}

class AddCategoryEvent extends AddDeleteUpdateCategoryEvent {
  final Category category;
  const AddCategoryEvent({required this.category});
  @override
  List<Object> get props => [category];
}

class UpdateCategoryEvent extends AddDeleteUpdateCategoryEvent {
  final Category category;
  final String categorySlugBeforeUpdate;
  const UpdateCategoryEvent({
    required this.category,
    required this.categorySlugBeforeUpdate,
  });

  @override
  List<Object> get props => [category, categorySlugBeforeUpdate];
}

class DeleteCategoryEvent extends AddDeleteUpdateCategoryEvent {
  final String categorySlug;

  const DeleteCategoryEvent({required this.categorySlug});

  @override
  List<Object> get props => [categorySlug];
}
