part of 'sale_bloc.dart';


abstract class SaleState {}

class SaleInitial extends SaleState {}

class SaleLoading extends SaleState {}

class SaleLoaded extends SaleState {
  final List<Sale> sales;
  SaleLoaded(this.sales);
}

class SaleDetailLoaded extends SaleState {
  final Sale sale;
  SaleDetailLoaded(this.sale);
}

class SaleError extends SaleState {
  final String message;
  SaleError(this.message);
}

class SaleOperationSuccess extends SaleState {
  final String message;
  SaleOperationSuccess(this.message);
}
