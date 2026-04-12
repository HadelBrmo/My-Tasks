import 'package:dio/dio.dart';
import 'package:mytasks/features/products/data/models/product.dart' show ProductModel;

abstract class ProductRemoteDataSource{
  Future<List<ProductModel>> getProducts();
 
}
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource{

 final Dio dio;
    ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get("/products");
      if (response.statusCode == 200) {
        final List data = response.data['products'] ?? [];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.type.toString()} - ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}