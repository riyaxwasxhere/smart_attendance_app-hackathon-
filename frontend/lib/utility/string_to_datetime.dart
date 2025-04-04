import 'package:intl/intl.dart';

DateTime getDatetimeFromStr(timeStr) {
  DateTime now = DateTime.now();
  String todayDate = DateFormat('yyyy-MMM-dd').format(now);

  String dateTimeString = "$todayDate $timeStr";

  DateTime dateTime = DateFormat('yyyy-MMM-dd hh:mm a').parse(dateTimeString);

  return dateTime;
}
