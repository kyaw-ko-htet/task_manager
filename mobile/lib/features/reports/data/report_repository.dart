import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/core/network/api_endpoints.dart';
import 'package:mobile/core/errors/exceptions.dart';

class ReportRepository {
  final DioClient dioClient;
  ReportRepository({required this.dioClient});

  Future<Map<String, dynamic>> salesReport({String period = 'daily', String? from, String? to}) async {
    try {
      final q = <String, dynamic>{'period': period};
      if (from != null) q['from'] = from;
      if (to != null) q['to'] = to;
      final res = await dioClient.get(ApiEndpoints.reportsSales, query: q);
      return res.data['data'] as Map<String, dynamic>;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  Future<Map<String, dynamic>> expensesReport({String? from, String? to, String groupBy = 'category'}) async {
    try {
      final q = <String, dynamic>{'groupBy': groupBy};
      if (from != null) q['from'] = from;
      if (to != null) q['to'] = to;
      final res = await dioClient.get(ApiEndpoints.reportsExpenses, query: q);
      return res.data['data'] as Map<String, dynamic>;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  Future<Map<String, dynamic>> summary({String? from, String? to}) async {
    try {
      final q = <String, dynamic>{};
      if (from != null) q['from'] = from;
      if (to != null) q['to'] = to;
      final res = await dioClient.get(ApiEndpoints.reportsSummary, query: q.isEmpty ? null : q);
      return res.data['data'] as Map<String, dynamic>;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
