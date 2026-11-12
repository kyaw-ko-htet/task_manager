import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_pocky/features/sales/domain/repositories/sale_repository.dart';
import 'package:my_pocky/features/sales/domain/entities/sale.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final SaleRepository repository;

  SaleBloc({required this.repository}) : super(SaleInitial()) {
    on<SaleLoadRequested>(_onLoad);
    on<SaleCreateRequested>(_onCreate);
    on<SaleDetailRequested>(_onDetail);
  }

  Future<void> _onLoad(SaleLoadRequested event, Emitter<SaleState> emit) async {
    emit(SaleLoading());
    try {
      final sales = await repository.getSales(from: event.from, to: event.to);
      emit(SaleLoaded(sales));
    } catch (e) {
      emit(SaleError(e.toString()));
    }
  }

  Future<void> _onCreate(SaleCreateRequested event, Emitter<SaleState> emit) async {
    try {
      await repository.createSale(event.data);
      emit(SaleOperationSuccess('Sale recorded'));
      add(SaleLoadRequested());
    } catch (e) {
      emit(SaleError(e.toString()));
    }
  }

  Future<void> _onDetail(SaleDetailRequested event, Emitter<SaleState> emit) async {
    emit(SaleLoading());
    try {
      final sale = await repository.getSale(event.id);
      emit(SaleDetailLoaded(sale));
    } catch (e) {
      emit(SaleError(e.toString()));
    }
  }
}
