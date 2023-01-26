import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../Domain/entities/product.dart';
import '../../../Domain/user_cases/get_all_products.dart';
import '../../../Domain/user_cases/get_single_product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final GetSingleProductUseCase getSingleProductUseCase;
  ProductsBloc(
      {required this.getAllProductsUseCase,
      required this.getSingleProductUseCase})
      : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      if (event is GetAllProductsEvent || event is RefreshProductsEvent) {
        emit(LoadingProductsState());
        // callable class
        final failureOrProducts = await getAllProductsUseCase();
        failureOrProducts.fold(
            (failure) => emit(ErrorProductsState(message: failure.message)),
            (products) => emit(LoadedProductsState(productsList: products)));
      } else if (event is GetSingleProductEvent) {
        emit(LoadingProductsState());
        final failureOrProduct =
            await getSingleProductUseCase(event.productSlug);
        failureOrProduct.fold(
          (failure) => emit(ErrorProductsState(message: failure.message)),
          (product) => emit(GetSingleProductState(product: product)),
        );
      }
    });
  }
}
