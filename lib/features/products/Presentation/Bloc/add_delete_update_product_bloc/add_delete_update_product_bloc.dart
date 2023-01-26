import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/success_strings.dart';
import '../../../Domain/entities/product.dart';
import '../../../Domain/user_cases/add_product.dart';
import '../../../Domain/user_cases/delete_product.dart';
import '../../../Domain/user_cases/update_product.dart';

part 'add_delete_update_product_event.dart';
part 'add_delete_update_product_state.dart';

class AddDeleteUpdateProductBloc
    extends Bloc<AddDeleteUpdateProductEvent, AddDeleteUpdateProductState> {
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  AddDeleteUpdateProductBloc({
    required this.addProductUseCase,
    required this.deleteProductUseCase,
    required this.updateProductUseCase,
  }) : super(AddDeleteUpdateProductInitial()) {
    on<AddDeleteUpdateProductEvent>((event, emit) async {
      emit(LoadingAddDeleteUpdateProductState());
      // add product
      if (event is AddProductEvent) {
        final failureOrDone = await addProductUseCase(event.product);
        emit(errorOrSuccessState(failureOrDone, PRODUCT_ADD_SUCCESS_MESSAGE));
      }
      // update product
      else if (event is UpdateProductEvent) {
        final failureOrDone = await updateProductUseCase(
          event.product,
          event.productSlugBeforeUpdate,
        );
        emit(
            errorOrSuccessState(failureOrDone, PRODUCT_UPDATE_SUCCESS_MESSAGE));
      }
      // delete product
      else if (event is DeleteProductEvent) {
        final failureOrDone = await deleteProductUseCase(event.productSlug);
        emit(
            errorOrSuccessState(failureOrDone, PRODUCT_DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdateProductState errorOrSuccessState(
      Either<Failure, Unit> failureOrDone, String successMessage) {
    return failureOrDone.fold(
      (failure) => ErrorAddDeleteUpdateProductState(message: failure.message),
      (success) => SuccessAddDeleteUpdateProductState(
        message: successMessage,
      ),
    );
  }
}

