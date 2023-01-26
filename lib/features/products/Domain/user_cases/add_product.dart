import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/products_repository.dart';

import '../entities/product.dart';

class AddProductUseCase {
  final ProductsRepository repository;

  AddProductUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Product product) async {
    return await repository.addProduct(product);
  }
}
