import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/core/network/api_endpoints.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/sales/domain/repositories/sale_repository.dart';
import 'package:mobile/features/sales/domain/entities/sale.dart';
import 'package:mobile/features/sales/data/models/sale_model.dart';

class SaleRepositoryImpl implements SaleRepository {
  final DioClient dioClient;
  SaleRepositoryImpl({required this.dioClient});

  @override
  Future<List<Sale>> getSales({String? from, String? to}) async {
    try {
      final query = <String, dynamic>{};
      if (from != null) query['from'] = from;
      if (to != null) query['to'] = to;
      final res = await dioClient.get(ApiEndpoints.sales, query: query.isEmpty ? null : query);
      final list = (res.data['data']['items'] as List).cast<Map<String, dynamic>>();
      return list.map(SaleModel.fromJson).toList();
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Sale> getSale(String id) async {
    final res = await dioClient.get(ApiEndpoints.sale(id));
    return SaleModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<Sale> createSale(Map<String, dynamic> data) async {
    final res = await dioClient.post(ApiEndpoints.sales, data: data);
    return SaleModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }
}
