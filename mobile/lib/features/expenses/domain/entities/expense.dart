class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime expenseDate;
  final String? notes;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.expenseDate,
    this.notes,
  });
}
