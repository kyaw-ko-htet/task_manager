import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/sales/presentation/bloc/sale_bloc.dart';
import 'package:mobile/core/utils/formatters.dart';

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
        onPressed: () => context.go('/sales/new'),
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
            if (state.sales.isEmpty) return const Center(child: Text('No sales'));
            return ListView.builder(
              itemCount: state.sales.length,
              itemBuilder: (context, i) {
                final s = state.sales[i];
                return ListTile(
                  title: Text(Formatters.money(s.total)),
                  subtitle: Text(s.formattedDate),
                  trailing: Text(Formatters.money(s.profit)),
                  onTap: () => context.go('/sales/${s.id}'),
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
