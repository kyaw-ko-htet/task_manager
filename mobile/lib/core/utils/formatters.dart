import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static String money(num value, {String symbol = 'MMK '}) {
    final f = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return f.format(value);
  }

  static String date(DateTime d) => DateFormat('yyyy-MM-dd').format(d);
  static String dateTime(DateTime d) => DateFormat('yyyy-MM-dd HH:mm').format(d);
}