import 'package:my_pocky/features/sales/domain/entities/sale.dart';

class SaleModel extends Sale {
  const SaleModel({
    required super.id,
    required super.saleDate,
    required super.subtotal,
    required super.discountAmount,
    required super.total,
    required super.profit,
    super.notes,
    required super.items,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = (json['items'] as List?) ?? [];
    return SaleModel(
      id: json['id'] as String,
      saleDate: DateTime.parse(json['saleDate'] as String),
      subtotal: (json['subtotal'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      notes: json['notes'] as String?,
      items: itemsJson.map((e) {
        final m = e as Map<String, dynamic>;
        return SaleItem(
          id: m['id'] as String,
          productId: m['productId'] as String?,
          productName: m['productName'] as String,
          quantity: (m['quantity'] as num).toInt(),
          costPrice: (m['costPrice'] as num).toDouble(),
          sellingPrice: (m['sellingPrice'] as num).toDouble(),
          lineTotal: (m['lineTotal'] as num).toDouble(),
          lineProfit: (m['lineProfit'] as num).toDouble(),
        );
      }).toList(),
    );
  }
}
