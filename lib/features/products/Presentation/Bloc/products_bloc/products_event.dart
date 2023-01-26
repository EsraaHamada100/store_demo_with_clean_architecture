part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetAllProductsEvent extends ProductsEvent {}

class GetSingleProductEvent extends ProductsEvent {
  final String productSlug;
  const GetSingleProductEvent({required this.productSlug});
  
  @override
  List<Object> get props => [productSlug];
}

class RefreshProductsEvent extends ProductsEvent {}
