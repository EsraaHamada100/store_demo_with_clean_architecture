import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/strings/success_strings.dart';
import '../../../domain/use_cases/add_category.dart';
import '../../../domain/use_cases/delete_category.dart';
import '../../../domain/use_cases/update_categories.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/category.dart';

part 'add_delete_update_category_event.dart';
part 'add_delete_update_category_state.dart';

class AddDeleteUpdateCategoryBloc
    extends Bloc<AddDeleteUpdateCategoryEvent, AddDeleteUpdateCategoryState> {
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;
  AddDeleteUpdateCategoryBloc({
    required this.addCategoryUseCase,
    required this.updateCategoryUseCase,
    required this.deleteCategoryUseCase,
  }) : super(AddDeleteUpdateCategoryInitial()) {
    on<AddDeleteUpdateCategoryEvent>((event, emit) async {
      emit(LoadingAddDeleteUpdateCategoryState());
      // add category
      if (event is AddCategoryEvent) {
        final failureOrDone = await addCategoryUseCase(event.category);
        emit(
          _getSuccessOrErrorState(
            failureOrDone: failureOrDone,
            successMessage: CATEGORY_ADD_SUCCESS_MESSAGE,
          ),
        );
      }
      // update category
      else if (event is UpdateCategoryEvent) {
        final failureOrDone = await updateCategoryUseCase(
          event.category,
          event.categorySlugBeforeUpdate,
        );
        emit(
          _getSuccessOrErrorState(
            failureOrDone: failureOrDone,
            successMessage: CATEGORY_UPDATE_SUCCESS_MESSAGE,
          ),
        );
      }
      // delete category
      else if (event is DeleteCategoryEvent) {
        final failureOrDone = await deleteCategoryUseCase(event.categorySlug);
        emit(
          _getSuccessOrErrorState(
            failureOrDone: failureOrDone,
            successMessage: CATEGORY_DELETE_SUCCESS_MESSAGE,
          ),
        );
      }
    });
  }
  AddDeleteUpdateCategoryState _getSuccessOrErrorState(
      {required Either<Failure, Unit> failureOrDone,
      required String successMessage}) {
    return failureOrDone.fold(
      (failure) =>
          ErrorAddDeleteUpdateCategoryState(errorMessage: failure.message),
      (success) =>
          SuccessAddDeleteUpdateCategoryState(successMessage: successMessage),
    );
  }
}
