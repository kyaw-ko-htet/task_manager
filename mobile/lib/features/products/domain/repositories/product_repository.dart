import 'package:my_pocky/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({String? search});
  Future<Product> getProduct(String id);
  Future<Product> createProduct(Map<String, dynamic> data);
  Future<Product> updateProduct(String id, Map<String, dynamic> data);
  Future<void> deleteProduct(String id);
}
