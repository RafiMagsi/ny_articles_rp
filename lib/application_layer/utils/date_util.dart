import 'package:intl/intl.dart';

// Date formatter Utility
class DateUtil {
  static String formatDate(DateTime? date) {
    if (date == null) return "";
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(date);
  }
}
