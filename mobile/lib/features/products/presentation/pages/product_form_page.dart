import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/di/injection.dart';
import 'package:mobile/features/products/presentation/bloc/product_bloc.dart';
import 'package:mobile/features/products/domain/repositories/product_repository.dart';
import 'package:mobile/core/utils/validators.dart';

class ProductFormPage extends StatefulWidget {
  final String? id;
  const ProductFormPage({super.key, this.id});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _sku = TextEditingController();
  final _cost = TextEditingController();
  final _selling = TextEditingController();
  final _stock = TextEditingController();
  bool _loading = false;

  bool get isEdit => widget.id != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final p = await sl<ProductRepository>().getProduct(widget.id!);
    _name.text = p.name;
    _sku.text = p.sku;
    _cost.text = p.costPrice.toString();
    _selling.text = p.sellingPrice.toString();
    _stock.text = p.stockQuantity.toString();
    setState(() => _loading = false);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      'name': _name.text.trim(),
      'sku': _sku.text.trim(),
      'costPrice': double.parse(_cost.text),
      'sellingPrice': double.parse(_selling.text),
      'stockQuantity': int.parse(_stock.text),
    };
    final bloc = context.read<ProductBloc>();
    if (isEdit) {
      bloc.add(ProductUpdateRequested(widget.id!, data));
    } else {
      bloc.add(ProductCreateRequested(data));
    }
    context.go('/products');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Product' : 'New Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Name'), validator: Validators.required),
              TextFormField(controller: _sku, decoration: const InputDecoration(labelText: 'SKU'), validator: Validators.required),
              TextFormField(controller: _cost, decoration: const InputDecoration(labelText: 'Cost Price'), keyboardType: TextInputType.number, validator: Validators.number),
              TextFormField(controller: _selling, decoration: const InputDecoration(labelText: 'Selling Price'), keyboardType: TextInputType.number, validator: Validators.number),
              TextFormField(controller: _stock, decoration: const InputDecoration(labelText: 'Stock Quantity'), keyboardType: TextInputType.number, validator: Validators.positiveInt),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _submit, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
