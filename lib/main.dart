import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/resources/theme_manager.dart';
import 'home_page.dart';
import 'features/categories/presentation/bloc/categories_bloc/categories_bloc.dart';
import 'features/products/Presentation/Bloc/products_bloc/products_bloc.dart';
import 'injection_container.dart' as di;

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.getIt<ProductsBloc>()..add(GetAllProductsEvent()),
          ),
          BlocProvider(
            create: (_) =>
                di.getIt<CategoriesBloc>()..add(GetAllCategoriesEvent()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: getApplicationTheme(),
          home: const HomePage(),
        ),
      );
    });
  }
}
