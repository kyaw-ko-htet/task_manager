part of 'report_bloc.dart';

abstract class ReportEvent {}

class ReportLoadRequested extends ReportEvent {
  final String period;
  final String? from;
  final String? to;
  ReportLoadRequested({this.period = 'daily', this.from, this.to});
}
