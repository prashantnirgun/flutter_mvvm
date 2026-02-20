import 'package:intl/intl.dart';

class Formatters {
  // Currency formatter
  static String currency(
    num value, {
    String locale = 'en_IN',
    String symbol = '₹ ',
    int decimalPlaces = 2, // 👈 optional parameter
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalPlaces,
    );
    return formatter.format(value);
  }

  // Decimal formatter
  static String decimal(num value, {int decimals = 2}) {
    return value.toStringAsFixed(decimals);
  }

  // Date formatter
  static String date(String rawDate, {String pattern = 'dd-MM-yyyy'}) {
    final dateTime = DateTime.parse(rawDate);
    return DateFormat(pattern).format(dateTime);
  }
}
