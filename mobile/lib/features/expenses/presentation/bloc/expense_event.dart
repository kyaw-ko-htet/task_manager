part of 'expense_bloc.dart';

abstract class ExpenseEvent {}

class ExpenseLoadRequested extends ExpenseEvent {
  final String? from;
  final String? to;
  final String? category;
  ExpenseLoadRequested({this.from, this.to, this.category});
}

class ExpenseCreateRequested extends ExpenseEvent {
  final Map<String, dynamic> data;
  ExpenseCreateRequested(this.data);
}

class ExpenseUpdateRequested extends ExpenseEvent {
  final String id;
  final Map<String, dynamic> data;
  ExpenseUpdateRequested(this.id, this.data);
}

class ExpenseDeleteRequested extends ExpenseEvent {
  final String id;
  ExpenseDeleteRequested(this.id);
}
