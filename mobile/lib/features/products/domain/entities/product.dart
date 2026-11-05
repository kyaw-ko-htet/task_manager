class Product {
  final String id;
  final String name;
  final String sku;
  final double costPrice;
  final double sellingPrice;
  final int stockQuantity;

  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.costPrice,
    required this.sellingPrice,
    required this.stockQuantity,
  });
}
