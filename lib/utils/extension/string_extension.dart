import 'package:intl/intl.dart';
import 'package:robinhood_app_testing/utils/extension/extension.dart';

///string extension
extension StringExtension on String {
  ///parse [String] to [DateTime]
  DateTime toDateTime({String? format}) {
    try {
      return DateFormat(format ?? 'yyyy-MM-dd').parse(this);
    } catch (e) {
      return DateTime.now();
    }
  }

  String displayTime([String? format]) {
    var time = toDateTime();
    return format != null
        ? DateFormat(format).format(time)
        : time.dateDisplayFormat();
  }
}
