part of 'report_bloc.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final Map<String, dynamic> sales;
  final Map<String, dynamic> expenses;
  final Map<String, dynamic> summary;
  ReportLoaded({required this.sales, required this.expenses, required this.summary});
}

class ReportError extends ReportState {
  final String message;
  ReportError(this.message);
}
