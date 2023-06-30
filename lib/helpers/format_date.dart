import 'package:intl/intl.dart';

class FormatDate {
  static String toDmmmmyyyy(DateTime date, String curLoc) {
    return '${DateFormat.d().format(date)} ${DateFormat.MMMM(curLoc).format(date)} ${DateFormat.y().format(date)}';
  }
}
