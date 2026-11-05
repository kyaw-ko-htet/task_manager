part of 'expense_bloc.dart';


abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  ExpenseLoaded(this.expenses);
}

class ExpenseError extends ExpenseState {
  final String message;
  ExpenseError(this.message);
}

class ExpenseOperationSuccess extends ExpenseState {
  final String message;
  ExpenseOperationSuccess(this.message);
}
