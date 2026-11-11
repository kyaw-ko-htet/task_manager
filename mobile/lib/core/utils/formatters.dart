import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static String money(num value, {String symbol = 'MMK'}) {
    final f = NumberFormat('#,##0');
    return '${f.format(value)} $symbol';
  }

  static String date(DateTime d) => DateFormat('dd-MM-yyyy').format(d);
  static String dateTime(DateTime d) {
    DateTime myanmarTime = d.toUtc().add(const Duration(hours: 6, minutes: 30));
    return DateFormat('dd-MM-yyyy hh:mm a').format(myanmarTime);
  }
}
