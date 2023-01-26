part of 'add_delete_update_product_bloc.dart';

abstract class AddDeleteUpdateProductEvent extends Equatable {
  const AddDeleteUpdateProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends AddDeleteUpdateProductEvent {
  final Product product;
  const AddProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends AddDeleteUpdateProductEvent {
  final Product product;
  final String productSlugBeforeUpdate;
  const UpdateProductEvent({
    required this.product,
    required this.productSlugBeforeUpdate,
  });

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends AddDeleteUpdateProductEvent {
  final String productSlug;
  const DeleteProductEvent({required this.productSlug});

  @override
  List<Object> get props => [productSlug];
}
