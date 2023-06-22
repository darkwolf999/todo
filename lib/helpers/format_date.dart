import 'package:intl/intl.dart';
import 'package:todo/my_logger.dart';

class FormatDate {
  static String toDmmmmyyyy(DateTime date, String curLoc) {
    return '${DateFormat.d().format(date)} ${DateFormat.MMMM(curLoc).format(date)} ${DateFormat.y().format(date)}';
  }
}
