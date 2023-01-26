import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/resources/color_manager.dart';
import 'core/strings/failure_strings.dart';
import 'core/widgets/error_widget.dart';
import 'core/widgets/home_page_widgets/horizontal_list_widget.dart';
import 'core/widgets/loading_widget.dart';
import 'core/widgets/home_page_widgets/search_bar_widget.dart';
import 'package:sizer/sizer.dart';

import 'core/widgets/home_page_widgets/products_widget.dart';
import 'features/categories/presentation/bloc/categories_bloc/categories_bloc.dart';
import 'features/products/Presentation/Bloc/products_bloc/products_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _searchBarAndCategorySection(Theme.of(context)),
            _productsSection(),
          ],
        ),
      ),
    );
  }

  Expanded _searchBarAndCategorySection(ThemeData theme) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: ColorManager.mainColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.h),
            bottomRight: Radius.circular(5.h),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Store",
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 1.h),
              const SearchBarWidget(),
              SizedBox(height: 3.h),
              Text(
                'Category',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 1.h),
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is LoadingCategoriesState) {
                    return const LoadingWidget();
                  } else if (state is LoadedCategoriesState) {
                    List<String> categoriesList = state.categoriesList
                        .map((category) => category.name)
                        .toList();
                    return HorizontalListWidget(stringsList: categoriesList);
                  }

                  return const LoadingWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<ProductsBloc, ProductsState> _productsSection() {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state is LoadingProductsState) {
          return const Expanded(flex: 2, child: LoadingWidget());
        }
        if (state is LoadedProductsState) {
          return Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: RefreshIndicator(
                  onRefresh: () => _onProductRefresh(context),
                  child: ProductsWidget(productsList: state.productsList)),
            ),
          );
        }

        if (state is ErrorProductsState) {
          return Expanded(
            flex: 2,
            child: MyErrorWidget(errorMessage: state.message),
          );
        }
        return const Expanded(
          flex: 2,
          child: MyErrorWidget(errorMessage: UNKNOWN_FAILURE_MESSAGE),
        );
      },
    );
  }

  Future<void> _onProductRefresh(BuildContext context) async {
    BlocProvider.of<ProductsBloc>(context).add(RefreshProductsEvent());
  }
}
