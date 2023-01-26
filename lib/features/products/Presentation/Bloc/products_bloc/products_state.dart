part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class LoadingProductsState extends ProductsState {}

class LoadedProductsState extends ProductsState {
  final List<Product> productsList;
  const LoadedProductsState({required this.productsList});

  @override
  List<Object> get props => [productsList];
}

class GetSingleProductState extends ProductsState {
  final Product product;
  const GetSingleProductState({required this.product});

  @override
  List<Object> get props => [product];
}

class ErrorProductsState extends ProductsState {
  final String message;
  const ErrorProductsState({required this.message});

  @override
  List<Object> get props => [message];
}
