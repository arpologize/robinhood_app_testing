import 'package:intl/intl.dart';

///date extension
extension DateExtension on DateTime {
  String dateDisplayFormat() {
    return DateFormat('dd MMM yyyy').format(this);
  }
}
