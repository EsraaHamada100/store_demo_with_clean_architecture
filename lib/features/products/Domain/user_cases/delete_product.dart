import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/products_repository.dart';

class DeleteProductUseCase {
  final ProductsRepository repository;

  DeleteProductUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String productSlug) async {
    return await repository.deleteProduct(productSlug);
  }
}
