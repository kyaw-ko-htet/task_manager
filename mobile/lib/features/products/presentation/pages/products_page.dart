import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/products/presentation/bloc/product_bloc.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/core/utils/formatters.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/products/form'),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProductLoading || state is ProductInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.inventory_2_outlined, size: 48, color: AppTheme.colorOnSurfaceVariant),
                    SizedBox(height: 12),
                    Text('No products', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 4),
                    Text('Tap + to add your first product', style: TextStyle(fontSize: 14, color: AppTheme.colorOnSurfaceVariant)),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.products.length,
              itemBuilder: (context, i) {
                final p = state.products[i];
                return ListTile(
                  title: Text(p.name),
                  subtitle: Text('SKU: ${p.sku} | Stock: ${p.stockQuantity}'),
                  trailing: Text(Formatters.money(p.sellingPrice)),
                  onTap: () => context.go('/products/${p.id}'),
                  onLongPress: () => context.read<ProductBloc>().add(ProductDeleteRequested(p.id)),
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
