import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pocky/features/products/domain/entities/product.dart';
import 'package:my_pocky/features/products/domain/repositories/product_repository.dart';
import 'package:my_pocky/core/di/injection.dart';
import 'package:my_pocky/features/sales/presentation/bloc/sale_bloc.dart';
import 'package:my_pocky/core/utils/validators.dart';
import 'package:my_pocky/core/theme/app_theme.dart';

class SaleCreatePage extends StatefulWidget {
  const SaleCreatePage({super.key});

  @override
  State<SaleCreatePage> createState() => _SaleCreatePageState();
}

class _SaleCreatePageState extends State<SaleCreatePage> {
  List<Product> _products = [];
  final Map<String, int> _qty = {};
  final Map<String, TextEditingController> _qtyControllers = {};

  @override
  void dispose() {
    for (final c in _qtyControllers.values) {
      c.dispose();
    }
    super.dispose();
  }
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
      for (final p in products) {
        _qty[p.id] = 0;
        _qtyControllers[p.id] = TextEditingController(text: '0');
      }
      _loading = false;
    });
  }

  void _submit() {
    final items = _qty.entries
        .where((e) => e.value > 0)
        .map((e) => {'productId': e.key, 'quantity': e.value})
        .toList();
    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select at least one product')),
      );
      return;
    }
    final data = <String, dynamic>{
      'items': items,
      'discountType': _discountType,
      'discountValue': double.tryParse(_discountValue.text) ?? 0,
    };
    final notes = _notes.text.trim();
    if (notes.isNotEmpty) data['notes'] = notes;
    context.read<SaleBloc>().add(SaleCreateRequested(data));
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/sales');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('New Sale')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ..._products.map((p) {
              final q = _qty[p.id] ?? 0;
              return Card(
                child: ListTile(
                  title: Text(p.name),
                  subtitle: Text(
                    'Stock: ${p.stockQuantity} | ${p.sellingPrice}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: q > 0
                            ? () {
                                setState(() => _qty[p.id] = q - 1);
                                _qtyControllers[p.id]?.text = '${_qty[p.id]}';
                              }
                            : null,
                      ),
                      SizedBox(
                        width: 60,
                        child: TextFormField(
                          controller: _qtyControllers[p.id],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          ),
                          onChanged: (v) {
                            final val = int.tryParse(v) ?? 0;
                            final clamped = val.clamp(0, p.stockQuantity);
                            setState(() => _qty[p.id] = clamped);
                            if (val != clamped) {
                              _qtyControllers[p.id]?.text = '$clamped';
                              _qtyControllers[p.id]?.selection = TextSelection.collapsed(offset: '$clamped'.length);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: q < p.stockQuantity
                            ? () {
                                setState(() => _qty[p.id] = q + 1);
                                _qtyControllers[p.id]?.text = '${_qty[p.id]}';
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _discountType,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              alignment: Alignment.centerLeft,
              dropdownColor: AppTheme.colorSurface,
              borderRadius: BorderRadius.circular(8),
              style: const TextStyle(
                color: AppTheme.colorOnSurface,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                labelText: 'Discount Type',
                prefixIcon: Icon(Icons.discount_outlined),
              ),
              items: const [
                DropdownMenuItem(value: 'NONE', child: Text('None')),
                DropdownMenuItem(value: 'PERCENT', child: Text('Percent')),
                DropdownMenuItem(value: 'FIXED', child: Text('Fixed')),
              ],
              onChanged: (v) {
              setState(() {
                _discountType = v!;
                if (v == 'NONE') _discountValue.text = '0';
              });
            },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _discountValue,
              decoration: const InputDecoration(labelText: 'Discount Value'),
              keyboardType: TextInputType.number,
              validator: Validators.number,
            enabled: _discountType != 'NONE',
          ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notes,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Record Sale'),
            ),
          ],
        ),
      ),
    );
  }
}
