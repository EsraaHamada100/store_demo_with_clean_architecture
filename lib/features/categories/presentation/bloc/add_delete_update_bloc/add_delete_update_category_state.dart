part of 'add_delete_update_category_bloc.dart';

abstract class AddDeleteUpdateCategoryState extends Equatable {
  const AddDeleteUpdateCategoryState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateCategoryInitial extends AddDeleteUpdateCategoryState {}

class LoadingAddDeleteUpdateCategoryState extends AddDeleteUpdateCategoryState {
}

class SuccessAddDeleteUpdateCategoryState extends AddDeleteUpdateCategoryState {
  final String successMessage;
  const SuccessAddDeleteUpdateCategoryState({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class ErrorAddDeleteUpdateCategoryState extends AddDeleteUpdateCategoryState {
  final String errorMessage;
  const ErrorAddDeleteUpdateCategoryState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
