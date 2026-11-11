import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/core/utils/formatters.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(ExpenseLoadRequested());
  }

  void _showAddDialog() {
    final title = TextEditingController();
    final amount = TextEditingController();
    final category = TextEditingController(text: 'OTHER');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: title, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 12),
            TextField(controller: amount, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            TextField(controller: category, decoration: const InputDecoration(labelText: 'Category')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              context.read<ExpenseBloc>().add(ExpenseCreateRequested({
                    'title': title.text.trim(),
                    'amount': double.parse(amount.text),
                    'category': category.text.trim(),
                  }));
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      floatingActionButton: FloatingActionButton(onPressed: _showAddDialog, child: const Icon(Icons.add)),
      body: BlocConsumer<ExpenseBloc, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ExpenseError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ExpenseLoading || state is ExpenseInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ExpenseLoaded) {
            if (state.expenses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.money_off_outlined, size: 48, color: AppTheme.colorOnSurfaceVariant),
                    const SizedBox(height: 12),
                    const Text('No expenses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text('Tap + to add an expense', style: TextStyle(fontSize: 14, color: AppTheme.colorOnSurfaceVariant)),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.expenses.length,
              itemBuilder: (context, i) {
                final e = state.expenses[i];
                return ListTile(
                  title: Text(e.title),
                  subtitle: Text('${e.category} | ${e.expenseDate.toLocal()}'),
                  trailing: Text(Formatters.money(e.amount)),
                  onLongPress: () => context.read<ExpenseBloc>().add(ExpenseDeleteRequested(e.id)),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
