import 'package:intl/intl.dart';

class FormatNumber {
  static String format(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}
