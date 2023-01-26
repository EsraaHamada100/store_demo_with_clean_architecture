import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';
import '../../Domain/entities/product.dart';



// I made that abstract so if any thing happen to hive database
// I can simply replace it with another database
abstract class ProductsLocalDataSource {
  Future<List<Product>> getCachedProducts();
  Future<Unit> cacheProducts(List<ProductModel> productModels);
}

class ProductsLocalImplWithHive implements ProductsLocalDataSource {
  final Box<Product> productsBox;
  ProductsLocalImplWithHive({required this.productsBox});
  @override
  Future<Unit> cacheProducts(List<ProductModel> productModels) async {
    productsBox.clear();
    List<Product> productsList = productModels.cast<Product>();
    for (Product product in productsList) {
      productsBox.add((product));
    }

    return Future.value(unit);
  }

  @override
  Future<List<Product>> getCachedProducts() {
    final List<Product> productsList = productsBox.values.toList();

    if (productsList.isNotEmpty) {
      return Future.value(productsList);
    } else {
      throw EmptyCacheException();
    }
  }
}
