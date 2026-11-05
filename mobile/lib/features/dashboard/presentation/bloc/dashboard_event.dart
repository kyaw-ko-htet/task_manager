part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class DashboardLoadRequested extends DashboardEvent {
  final String? date;
  DashboardLoadRequested({this.date});
}
