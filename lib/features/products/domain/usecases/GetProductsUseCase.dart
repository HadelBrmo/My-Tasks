

import 'package:dartz/dartz.dart';
import 'package:mytasks/core/errors/failures/failure.dart';
import 'package:mytasks/features/products/domain/entities/productEntity.dart';
import 'package:mytasks/features/products/domain/repositories/ProductRepository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getProducts();
  }
}