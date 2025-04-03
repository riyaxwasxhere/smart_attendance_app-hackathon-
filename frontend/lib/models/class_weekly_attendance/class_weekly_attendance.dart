import 'package:frontend/models/class_weekly_attendance/class_weekly_attendance_item.dart';

class ClassWeeklyAttendance {
  final int dayOne;
  final int dayTwo;
  final int dayThree;
  final int dayFour;
  final int dayFive;
  final int daySix;
  final int daySeven;

  ClassWeeklyAttendance({
    required this.dayOne,
    required this.dayTwo,
    required this.dayThree,
    required this.dayFour,
    required this.dayFive,
    required this.daySix,
    required this.daySeven,
  });
  List<ClassWeeklyAttendanceItem> attendanceData = [];

  void initializeAttendanceData() {
    attendanceData = [
      ClassWeeklyAttendanceItem(x: 0, studentsPresent: dayOne),
      ClassWeeklyAttendanceItem(x: 1, studentsPresent: dayTwo),
      ClassWeeklyAttendanceItem(x: 2, studentsPresent: dayThree),
      ClassWeeklyAttendanceItem(x: 3, studentsPresent: dayFour),
      ClassWeeklyAttendanceItem(x: 4, studentsPresent: dayFive),
      ClassWeeklyAttendanceItem(x: 5, studentsPresent: daySix),
      ClassWeeklyAttendanceItem(x: 6, studentsPresent: daySeven),
    ];
  }
}
