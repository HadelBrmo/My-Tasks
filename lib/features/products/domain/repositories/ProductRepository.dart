

import 'package:dartz/dartz.dart';
import 'package:mytasks/core/errors/failures/failure.dart';
import 'package:mytasks/features/products/domain/entities/productEntity.dart';

abstract class ProductRepository {
 
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}