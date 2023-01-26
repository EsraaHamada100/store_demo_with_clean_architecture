import 'package:dartz/dartz.dart';
import '../entities/product.dart';

import '../../../../core/error/failure.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getSingleProduct(String productSlug);
  Future<Either<Failure, Unit>> addProduct(Product product);
  Future<Either<Failure, Unit>> updateProduct(Product product, String productSlugBeforeUpdate);
  Future<Either<Failure, Unit>> deleteProduct(String productSlug);
}
