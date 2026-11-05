import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/products/domain/entities/product.dart';
import 'package:mobile/features/products/domain/repositories/product_repository.dart';
import 'package:mobile/core/di/injection.dart';
import 'package:mobile/features/sales/presentation/bloc/sale_bloc.dart';
import 'package:mobile/core/utils/validators.dart';

class SaleCreatePage extends StatefulWidget {
  const SaleCreatePage({super.key});

  @override
  State<SaleCreatePage> createState() => _SaleCreatePageState();
}

class _SaleCreatePageState extends State<SaleCreatePage> {
  List<Product> _products = [];
  final Map<String, int> _qty = {};
  String _discountType = 'NONE';
  final _discountValue = TextEditingController(text: '0');
  final _notes = TextEditingController();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final products = await sl<ProductRepository>().getProducts();
    setState(() {
      _products = products;
      _loading = false;
    });
  }

  void _submit() {
    final items = _qty.entries
        .where((e) => e.value > 0)
        .map((e) => {'productId': e.key, 'quantity': e.value})
        .toList();
    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select at least one product')));
      return;
    }
    final data = {
      'items': items,
      'discountType': _discountType,
      'discountValue': double.tryParse(_discountValue.text) ?? 0,
      'notes': _notes.text.trim().isEmpty ? null : _notes.text.trim(),
    };
    context.read<SaleBloc>().add(SaleCreateRequested(data));
    context.go('/sales');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: const Text('New Sale')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ..._products.map((p) {
            final q = _qty[p.id] ?? 0;
            return Card(
              child: ListTile(
                title: Text(p.name),
                subtitle: Text('Stock: ${p.stockQuantity} | ${p.sellingPrice}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: q > 0 ? () => setState(() => _qty[p.id] = q - 1) : null,
                    ),
                    Text('$q'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: q < p.stockQuantity ? () => setState(() => _qty[p.id] = q + 1) : null,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _discountType,
            decoration: const InputDecoration(labelText: 'Discount Type'),
            items: const [
              DropdownMenuItem(value: 'NONE', child: Text('None')),
              DropdownMenuItem(value: 'PERCENT', child: Text('Percent')),
              DropdownMenuItem(value: 'FIXED', child: Text('Fixed')),
            ],
            onChanged: (v) => setState(() => _discountType = v!),
          ),
          TextFormField(
            controller: _discountValue,
            decoration: const InputDecoration(labelText: 'Discount Value'),
            keyboardType: TextInputType.number,
            validator: Validators.number,
          ),
          TextFormField(
            controller: _notes,
            decoration: const InputDecoration(labelText: 'Notes (optional)'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _submit, child: const Text('Record Sale')),
        ],
      ),
    );
  }
}
