import 'package:intl/intl.dart';

class RoutineItem {
  final String title;
  final String section;
  final String startTimeString;
  final String endTimeString;
  late DateTime startTime;
  late DateTime endTime;
  final String dept;

  RoutineItem({
    required this.title,
    required this.section,
    required this.startTimeString,
    required this.endTimeString,
    required this.dept,
  }) {
    startTime = _convertToDateTime(startTimeString);
    endTime = _convertToDateTime(endTimeString);
  }

  DateTime _convertToDateTime(String timeString) {
    DateFormat timeFormat = DateFormat("h:mm a");
    DateTime parsedTime = timeFormat.parse(timeString);
    DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      parsedTime.hour,
      parsedTime.minute,
    );
  }
}
