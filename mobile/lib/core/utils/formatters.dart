import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static String money(num value, {String symbol = '\$'}) {
    return '$symbol${value.toStringAsFixed(2)}';
  }

  static String date(DateTime d) => DateFormat('yyyy-MM-dd').format(d);
  static String dateTime(DateTime d) => DateFormat('yyyy-MM-dd HH:mm').format(d);
}
