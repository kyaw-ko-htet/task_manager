import 'package:my_pocky/core/network/dio_client.dart';
import 'package:my_pocky/core/network/api_endpoints.dart';
import 'package:my_pocky/core/errors/exceptions.dart';
import 'package:my_pocky/features/products/domain/repositories/product_repository.dart';
import 'package:my_pocky/features/products/domain/entities/product.dart';
import 'package:my_pocky/features/products/data/models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DioClient dioClient;
  ProductRepositoryImpl({required this.dioClient});

  @override
  Future<List<Product>> getProducts({String? search}) async {
    try {
      final res = await dioClient.get(ApiEndpoints.products, query: search != null ? {'search': search} : null);
      final list = (res.data['data']['items'] as List).cast<Map<String, dynamic>>();
      return list.map(ProductModel.fromJson).toList();
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Product> getProduct(String id) async {
    final res = await dioClient.get(ApiEndpoints.product(id));
    return ProductModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<Product> createProduct(Map<String, dynamic> data) async {
    final res = await dioClient.post(ApiEndpoints.products, data: data);
    return ProductModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<Product> updateProduct(String id, Map<String, dynamic> data) async {
    final res = await dioClient.put(ApiEndpoints.product(id), data: data);
    return ProductModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await dioClient.delete(ApiEndpoints.product(id));
  }
}
