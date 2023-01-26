import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/use_cases/get_all_categories.dart';
import '../../../domain/use_cases/get_single_category.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetSingleCategoryUseCase getSingleCategoryUseCase;
  CategoriesBloc({
    required this.getAllCategoriesUseCase,
    required this.getSingleCategoryUseCase,
  }) : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) async {
      if (event is GetAllCategoriesEvent || event is RefreshCategoriesEvent) {
        final failureOrCategories = await getAllCategoriesUseCase();
        failureOrCategories.fold(
          (failure) => emit(ErrorCategoriesState(message: failure.message)),
          (categories) =>
              emit(LoadedCategoriesState(categoriesList: categories)),
        );
      } else if (event is GetSingleCategoryEvent) {
        emit(LoadingCategoriesState());
        final failureOrCategory =
            await getSingleCategoryUseCase(event.categorySlug);
        failureOrCategory.fold(
          (failure) => emit(ErrorCategoriesState(message: failure.message)),
          (category) => emit(GetSingleCategoryState(category: category)),
        );
      }
    });
  }
}
