import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetAllProductsUseCase {
  final ProductsRepository repository;
  GetAllProductsUseCase(this.repository);
  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getAllProducts();
  }
}
