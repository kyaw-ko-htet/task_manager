part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductLoadRequested extends ProductEvent {}

class ProductCreateRequested extends ProductEvent {
  final Map<String, dynamic> data;
  ProductCreateRequested(this.data);
}

class ProductUpdateRequested extends ProductEvent {
  final String id;
  final Map<String, dynamic> data;
  ProductUpdateRequested(this.id, this.data);
}

class ProductDeleteRequested extends ProductEvent {
  final String id;
  ProductDeleteRequested(this.id);
}
