import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/reports/data/report_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository repository;

  ReportBloc({required this.repository}) : super(ReportInitial()) {
    on<ReportLoadRequested>(_onLoad);
  }

  Future<void> _onLoad(ReportLoadRequested event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    try {
      final sales = await repository.salesReport(period: event.period, from: event.from, to: event.to);
      final expenses = await repository.expensesReport(from: event.from, to: event.to);
      final summary = await repository.summary(from: event.from, to: event.to);
      emit(ReportLoaded(sales: sales, expenses: expenses, summary: summary));
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }
}
