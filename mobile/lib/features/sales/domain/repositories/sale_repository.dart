import 'package:my_pocky/features/sales/domain/entities/sale.dart';

abstract class SaleRepository {
  Future<List<Sale>> getSales({String? from, String? to});
  Future<Sale> getSale(String id);
  Future<Sale> createSale(Map<String, dynamic> data);
}
