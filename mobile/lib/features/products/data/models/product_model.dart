import 'package:mobile/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.sku,
    required super.costPrice,
    required super.sellingPrice,
    required super.stockQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as String,
        name: json['name'] as String,
        sku: json['sku'] as String,
        costPrice: (json['costPrice'] as num).toDouble(),
        sellingPrice: (json['sellingPrice'] as num).toDouble(),
        stockQuantity: (json['stockQuantity'] as num).toInt(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'sku': sku,
        'costPrice': costPrice,
        'sellingPrice': sellingPrice,
        'stockQuantity': stockQuantity,
      };
}
