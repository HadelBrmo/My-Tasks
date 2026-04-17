
import 'package:dartz/dartz.dart';
import 'package:mytasks/core/errors/failures/failure.dart';
import 'package:mytasks/features/products/data/datasources/ProductRemoteDataSource.dart';
import 'package:mytasks/features/products/domain/entities/productEntity.dart';
import 'package:mytasks/features/products/domain/repositories/ProductRepository.dart';


class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getProducts();

      final entities = remoteProducts.map((model) => ProductEntity(
        id: model.id ?? 0,
        title: model.title ?? '',
        price: model.price ?? 0.0,
        discount: model.discountPercentage ?? 0.0,
        rating: model.rating ?? 0.0,
        image: model.thumbnail ?? '',
      )).toList();

      return Right(entities);
    } catch (e) {
      print("❌ خطأ جلب البيانات: $e");
      return Left(ServerFailure(e.toString()));
    }
  }
}