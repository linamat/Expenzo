import 'package:intl/intl.dart';

extension DateTimeFormatterToString on DateTime {
  String convertDateToddMMyyyy() {
    final formatter = DateFormat('dd/MM/yyyy');
    final formattedTime = formatter.format(this);
    return formattedTime;
  }
}
