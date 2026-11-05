import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/core/network/api_endpoints.dart';
import 'package:mobile/core/errors/exceptions.dart';
import 'package:mobile/features/expenses/domain/repositories/expense_repository.dart';
import 'package:mobile/features/expenses/domain/entities/expense.dart';
import 'package:mobile/features/expenses/data/models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final DioClient dioClient;
  ExpenseRepositoryImpl({required this.dioClient});

  @override
  Future<List<Expense>> getExpenses({String? from, String? to, String? category}) async {
    try {
      final q = <String, dynamic>{};
      if (from != null) q['from'] = from;
      if (to != null) q['to'] = to;
      if (category != null) q['category'] = category;
      final res = await dioClient.get(ApiEndpoints.expenses, query: q.isEmpty ? null : q);
      final list = (res.data['data']['items'] as List).cast<Map<String, dynamic>>();
      return list.map(ExpenseModel.fromJson).toList();
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Expense> getExpense(String id) async {
    final res = await dioClient.get(ApiEndpoints.expense(id));
    return ExpenseModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<Expense> createExpense(Map<String, dynamic> data) async {
    final res = await dioClient.post(ApiEndpoints.expenses, data: data);
    return ExpenseModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<Expense> updateExpense(String id, Map<String, dynamic> data) async {
    final res = await dioClient.put(ApiEndpoints.expense(id), data: data);
    return ExpenseModel.fromJson(res.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteExpense(String id) async {
    await dioClient.delete(ApiEndpoints.expense(id));
  }
}
