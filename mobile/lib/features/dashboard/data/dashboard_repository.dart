import 'package:my_pocky/core/network/dio_client.dart';
import 'package:my_pocky/core/network/api_endpoints.dart';
import 'package:my_pocky/core/errors/exceptions.dart';

class DashboardRepository {
  final DioClient dioClient;
  DashboardRepository({required this.dioClient});

  Future<Map<String, dynamic>> getSummary({String? date}) async {
    try {
      final res = await dioClient.get(ApiEndpoints.dashboardSummary, query: date != null ? {'date': date} : null);
      return res.data['data'] as Map<String, dynamic>;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
