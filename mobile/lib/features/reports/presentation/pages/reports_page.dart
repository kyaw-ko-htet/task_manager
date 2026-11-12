import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pocky/features/reports/presentation/bloc/report_bloc.dart';
import 'package:my_pocky/core/utils/formatters.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String _period = 'daily';

  @override
  void initState() {
    super.initState();
    context.read<ReportBloc>().add(ReportLoadRequested(period: _period));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) {
          if (state is ReportLoading || state is ReportInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ReportError) return Center(child: Text(state.message));
          final s = (state as ReportLoaded).summary;
          final sales = state.sales;
          final totals = sales['totals'] as Map<String, dynamic>;
          final series = (sales['series'] as List).cast<Map<String, dynamic>>();
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              DropdownButton<String>(
                value: _period,
                items: const [
                  DropdownMenuItem(value: 'daily', child: Text('Daily')),
                  DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                  DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                ],
                onChanged: (v) {
                  setState(() => _period = v!);
                  context.read<ReportBloc>().add(ReportLoadRequested(period: _period));
                },
              ),
              const SizedBox(height: 8),
              Text('Revenue: ${Formatters.money((s['revenue'] as num).toDouble())}'),
              Text('Profit: ${Formatters.money((s['profit'] as num).toDouble())}'),
              Text('Expenses: ${Formatters.money((s['totalExpenses'] as num).toDouble())}'),
              Text('Net: ${Formatters.money((s['net'] as num).toDouble())}'),
              Text('Transactions: ${s['transactions']}'),
              const Divider(),
              const Text('Series', style: TextStyle(fontWeight: FontWeight.bold)),
              ...series.map((e) => ListTile(
                    title: Text(e['period'].toString()),
                    subtitle: Text('Revenue ${Formatters.money((e['revenue'] as num).toDouble())} | Profit ${Formatters.money((e['profit'] as num).toDouble())}'),
                    trailing: Text('${e['transactions']} tx'),
                  )),
              const Divider(),
              Text('Totals: ${Formatters.money((totals['revenue'] as num).toDouble())}'),
            ],
          );
        },
      ),
    );
  }
}
