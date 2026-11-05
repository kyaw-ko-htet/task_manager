import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/expenses/domain/repositories/expense_repository.dart';
import 'package:mobile/features/expenses/domain/entities/expense.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository repository;

  ExpenseBloc({required this.repository}) : super(ExpenseInitial()) {
    on<ExpenseLoadRequested>(_onLoad);
    on<ExpenseCreateRequested>(_onCreate);
    on<ExpenseUpdateRequested>(_onUpdate);
    on<ExpenseDeleteRequested>(_onDelete);
  }

  Future<void> _onLoad(ExpenseLoadRequested event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      final items = await repository.getExpenses(from: event.from, to: event.to, category: event.category);
      emit(ExpenseLoaded(items));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onCreate(ExpenseCreateRequested event, Emitter<ExpenseState> emit) async {
    try {
      await repository.createExpense(event.data);
      emit(ExpenseOperationSuccess('Expense added'));
      add(ExpenseLoadRequested());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onUpdate(ExpenseUpdateRequested event, Emitter<ExpenseState> emit) async {
    try {
      await repository.updateExpense(event.id, event.data);
      emit(ExpenseOperationSuccess('Expense updated'));
      add(ExpenseLoadRequested());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onDelete(ExpenseDeleteRequested event, Emitter<ExpenseState> emit) async {
    try {
      await repository.deleteExpense(event.id);
      emit(ExpenseOperationSuccess('Expense deleted'));
      add(ExpenseLoadRequested());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}
