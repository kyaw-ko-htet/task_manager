import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/dashboard/data/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    on<DashboardLoadRequested>(_onLoad);
  }

  Future<void> _onLoad(DashboardLoadRequested event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final data = await repository.getSummary(date: event.date);
      emit(DashboardLoaded(data));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
