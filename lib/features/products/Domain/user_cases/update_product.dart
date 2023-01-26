import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class UpdateProductUseCase {
  final ProductsRepository repository;
  UpdateProductUseCase(this.repository);
  Future<Either<Failure, Unit>> call(Product product, String productSlugBeforeUpdate) async {
    return await repository.updateProduct(product, productSlugBeforeUpdate);
  }
}
