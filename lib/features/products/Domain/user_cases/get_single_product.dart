import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetSingleProductUseCase {
  final ProductsRepository repository;

  GetSingleProductUseCase(this.repository);

  Future<Either<Failure, Product>> call(String productSlug) async {
    return await repository.getSingleProduct(productSlug);
  }
}
