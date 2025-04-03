import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/class_weekly_attendance/class_weekly_attendance.dart';
// import 'package:frontend/models/class_weekly_attendance/class_weekly_attendance_item.dart';
// import 'package:frontend/screens/teacher_screens/class_summary.dart';

class AttendanceWeeklyChart extends StatefulWidget {
  const AttendanceWeeklyChart({super.key});

  @override
  State<AttendanceWeeklyChart> createState() => _AttendanceWeeklyChartState();
}

class _AttendanceWeeklyChartState extends State<AttendanceWeeklyChart> {
  final ClassWeeklyAttendance weeklyAttendance = ClassWeeklyAttendance(
    dayOne: 30,
    dayTwo: 50,
    dayThree: 56,
    dayFour: 40,
    dayFive: 25,
    daySix: 60,
    daySeven: 35,
  );

  @override
  void initState() {
    super.initState();
    weeklyAttendance.initializeAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1), // Slow down animation
      builder: (context, animationValue, child) {
        return BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(
              show: false,
              border: const Border(
                left: BorderSide(color: Colors.black, width: 1),
                bottom: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getBottomtitles,
                  reservedSize: 30,
                ),
              ),
            ),
            maxY: 60,
            minY: 0,
            barGroups: _getBarGroups(animationValue), // Pass animation value
          ),
        );
      },
    );
  }

  List<BarChartGroupData> _getBarGroups(double animationValue) {
    return [
      for (final item in weeklyAttendance.attendanceData)
        BarChartGroupData(
          x: item.x,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: item.studentsPresent * animationValue, // Apply animation
              color: const Color.fromARGB(255, 29, 126, 159),
              width: 40,
              borderRadius: BorderRadius.circular(4),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                color: const Color.fromARGB(255, 166, 233, 255),
                toY: 60,
              ),
            ),
          ],
        ),
    ];
  }

  Widget getBottomtitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text("Day1", style: style);
        break;
      case 1:
        text = const Text("Day2", style: style);
        break;
      case 2:
        text = const Text("Day3", style: style);
        break;
      case 3:
        text = const Text("Day4", style: style);
        break;
      case 4:
        text = const Text("Day5", style: style);
        break;
      case 5:
        text = const Text("Day6", style: style);
        break;
      case 6:
        text = const Text("Day7", style: style);
        break;
      default:
        text = const Text("");
        break;
    }

    return SideTitleWidget(meta: meta, child: text);
  }
}
