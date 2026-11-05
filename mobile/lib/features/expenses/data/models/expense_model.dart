import 'package:mobile/features/expenses/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  const ExpenseModel({
    required super.id,
    required super.title,
    required super.amount,
    required super.category,
    required super.expenseDate,
    super.notes,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
        id: json['id'] as String,
        title: json['title'] as String,
        amount: (json['amount'] as num).toDouble(),
        category: json['category'] as String,
        expenseDate: DateTime.parse(json['expenseDate'] as String),
        notes: json['notes'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'amount': amount,
        'category': category,
        'expenseDate': expenseDate.toIso8601String(),
        'notes': notes,
      };
}
