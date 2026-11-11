import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:mobile/core/utils/formatters.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(DashboardLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading || state is DashboardInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DashboardError) {
            return Center(child: Text(state.message));
          }
          final data = (state as DashboardLoaded).data;
          final totalSales = (data['totalSales'] as num).toDouble();
          final totalProfit = (data['totalProfit'] as num).toDouble();
          final tx = data['totalTransactions'] as int;
          final sold = data['totalProductsSold'] as int;
          final recent = (data['recentSales'] as List)
              .cast<Map<String, dynamic>>();

          return RefreshIndicator(
            onRefresh: () async =>
                context.read<DashboardBloc>().add(DashboardLoadRequested()),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    _card('Sales', Formatters.money(totalSales)),
                    const SizedBox(width: 8),
                    _card('Profit', Formatters.money(totalProfit)),
                  ],
                ),
                Row(
                  children: [
                    _card('Transactions', '$tx'),
                    const SizedBox(width: 8),
                    _card('Products Sold', '$sold'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Recent Sales',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ...recent.map(
                  (r) => ListTile(
                    title: Text(
                      Formatters.money((r['total'] as num).toDouble()),
                    ),
                    // subtitle: Text(r['saleDate'].toString()),
                    subtitle: Text(
                      Formatters.dateTime(
                        DateTime.parse(r['saleDate'].toString()),
                      ),
                    ),
                    trailing: Text(
                      Formatters.money((r['profit'] as num).toDouble()),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.push('/sales/new'),
                  child: const Text('New Sale'),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => context.push('/products'),
                      child: const Text('Products'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.push('/expenses'),
                      child: const Text('Expenses'),
                    ),
                    OutlinedButton(
                      onPressed: () => context.push('/reports'),
                      child: const Text('Reports'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _card(String title, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
