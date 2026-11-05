import 'package:intl/intl.dart';

class SaleItem {
  final String id;
  final String? productId;
  final String productName;
  final int quantity;
  final double costPrice;
  final double sellingPrice;
  final double lineTotal;
  final double lineProfit;

  const SaleItem({
    required this.id,
    this.productId,
    required this.productName,
    required this.quantity,
    required this.costPrice,
    required this.sellingPrice,
    required this.lineTotal,
    required this.lineProfit,
  });
}

class Sale {
  final String id;
  final DateTime saleDate;
  final double subtotal;
  final double discountAmount;
  final double total;
  final double profit;
  final String? notes;
  final List<SaleItem> items;

  const Sale({
    required this.id,
    required this.saleDate,
    required this.subtotal,
    required this.discountAmount,
    required this.total,
    required this.profit,
    this.notes,
    required this.items,
  });

  String get formattedDate => DateFormat('yyyy-MM-dd HH:mm').format(saleDate);
}
