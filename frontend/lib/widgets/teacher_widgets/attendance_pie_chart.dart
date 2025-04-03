import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AttendancePieChart extends StatelessWidget {
  final int presentCount;
  final int absentCount;

  AttendancePieChart({required this.presentCount, required this.absentCount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Today's Attendance",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: _generatePieSections(),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generatePieSections() {
    return [
      PieChartSectionData(
        color: const Color.fromARGB(255, 143, 243, 147),
        value: presentCount.toDouble(),
        title: "Present\n$presentCount",
        radius: 70,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      PieChartSectionData(
        color: const Color.fromARGB(255, 251, 163, 156),
        value: absentCount.toDouble(),
        title: "Absent\n$absentCount",
        radius: 70,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }
}
