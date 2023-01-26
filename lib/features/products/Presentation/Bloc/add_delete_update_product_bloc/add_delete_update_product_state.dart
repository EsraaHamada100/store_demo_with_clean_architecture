part of 'add_delete_update_product_bloc.dart';

abstract class AddDeleteUpdateProductState extends Equatable {
  const AddDeleteUpdateProductState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateProductInitial extends AddDeleteUpdateProductState {}

class LoadingAddDeleteUpdateProductState extends AddDeleteUpdateProductState {}

class SuccessAddDeleteUpdateProductState extends AddDeleteUpdateProductState {
  final String message;
  const SuccessAddDeleteUpdateProductState({required this.message});

  @override
  List<Object> get props => [message];
}


class ErrorAddDeleteUpdateProductState extends AddDeleteUpdateProductState {
  final String message;
  const ErrorAddDeleteUpdateProductState({required this.message});

  @override
  List<Object> get props => [message];
}
