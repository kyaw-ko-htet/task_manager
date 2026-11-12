import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pocky/features/sales/presentation/bloc/sale_bloc.dart';
import 'package:my_pocky/core/theme/app_theme.dart';
import 'package:my_pocky/core/utils/formatters.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  void initState() {
    super.initState();
    context.read<SaleBloc>().add(SaleLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/sales/new'),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<SaleBloc, SaleState>(
        listener: (context, state) {
          if (state is SaleOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is SaleError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is SaleLoading || state is SaleInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SaleLoaded) {
            if (state.sales.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 48, color: AppTheme.colorOnSurfaceVariant),
                    const SizedBox(height: 12),
                    const Text('No sales', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text('Tap + to record a sale', style: TextStyle(fontSize: 14, color: AppTheme.colorOnSurfaceVariant)),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.sales.length,
              itemBuilder: (context, i) {
                final s = state.sales[i];
                return ListTile(
                  title: Text(Formatters.money(s.total)),
                  subtitle: Text(s.formattedDate),
                  trailing: Text(Formatters.money(s.profit)),
                  onTap: () => context.push('/sales/${s.id}'),
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
