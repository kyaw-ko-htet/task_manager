part of 'sale_bloc.dart';

abstract class SaleEvent {}

class SaleLoadRequested extends SaleEvent {
  final String? from;
  final String? to;
  SaleLoadRequested({this.from, this.to});
}

class SaleCreateRequested extends SaleEvent {
  final Map<String, dynamic> data;
  SaleCreateRequested(this.data);
}

class SaleDetailRequested extends SaleEvent {
  final String id;
  SaleDetailRequested(this.id);
}
