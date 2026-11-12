import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pocky/features/sales/presentation/bloc/sale_bloc.dart';
import 'package:my_pocky/core/utils/formatters.dart';

class SaleDetailPage extends StatefulWidget {
  final String id;
  const SaleDetailPage({super.key, required this.id});

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<SaleBloc>().add(SaleDetailRequested(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Detail'),
      ),
      body: BlocBuilder<SaleBloc, SaleState>(
        builder: (context, state) {
          if (state is SaleLoading) return const Center(child: CircularProgressIndicator());
          if (state is SaleDetailLoaded) {
            final s = state.sale;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Date: ${s.formattedDate}'),
                Text('Subtotal: ${Formatters.money(s.subtotal)}'),
                Text('Discount: ${Formatters.money(s.discountAmount)}'),
                Text('Total: ${Formatters.money(s.total)}'),
                Text('Profit: ${Formatters.money(s.profit)}'),
                if (s.notes != null) Text('Notes: ${s.notes}'),
                const Divider(),
                ...s.items.map((it) => ListTile(
                      title: Text(it.productName),
                      subtitle: Text('Qty: ${it.quantity} x ${Formatters.money(it.sellingPrice)}'),
                      trailing: Text(Formatters.money(it.lineTotal)),
                    )),
              ],
            );
          }
          if (state is SaleError) return Center(child: Text(state.message));
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
