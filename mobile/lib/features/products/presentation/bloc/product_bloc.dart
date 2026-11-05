import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/products/domain/repositories/product_repository.dart';
import 'package:mobile/features/products/domain/entities/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<ProductLoadRequested>(_onLoad);
    on<ProductCreateRequested>(_onCreate);
    on<ProductUpdateRequested>(_onUpdate);
    on<ProductDeleteRequested>(_onDelete);
  }

  Future<void> _onLoad(ProductLoadRequested event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await repository.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onCreate(ProductCreateRequested event, Emitter<ProductState> emit) async {
    try {
      await repository.createProduct(event.data);
      emit(ProductOperationSuccess('Product created'));
      add(ProductLoadRequested());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdate(ProductUpdateRequested event, Emitter<ProductState> emit) async {
    try {
      await repository.updateProduct(event.id, event.data);
      emit(ProductOperationSuccess('Product updated'));
      add(ProductLoadRequested());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onDelete(ProductDeleteRequested event, Emitter<ProductState> emit) async {
    try {
      await repository.deleteProduct(event.id);
      emit(ProductOperationSuccess('Product deleted'));
      add(ProductLoadRequested());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
