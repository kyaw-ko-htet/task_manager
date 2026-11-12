import 'package:my_pocky/features/expenses/domain/entities/expense.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getExpenses({String? from, String? to, String? category});
  Future<Expense> getExpense(String id);
  Future<Expense> createExpense(Map<String, dynamic> data);
  Future<Expense> updateExpense(String id, Map<String, dynamic> data);
  Future<void> deleteExpense(String id);
}
