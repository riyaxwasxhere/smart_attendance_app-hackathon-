import 'package:flutter/material.dart';
import 'package:frontend/widgets/teacher_widgets/attendance_pie_chart.dart';
import 'package:frontend/widgets/teacher_widgets/attendance_weekly_chart.dart';
import 'package:frontend/widgets/teacher_widgets/student_list.dart';

class ClassSummary extends StatefulWidget {
  const ClassSummary({
    super.key,
    required this.subject,
    required this.className,
  });

  final String subject;
  final String className;

  @override
  State<ClassSummary> createState() => _ClassSummaryState();
}

class _ClassSummaryState extends State<ClassSummary> {
  void showAllStudents(String subject) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return StudentList(subject: subject);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Summary"),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          children: [
            Text("Total classes: 25", style: theme.textTheme.titleLarge),
            const SizedBox(height: 32),
            AttendancePieChart(presentCount: 40, absentCount: 20),
            const SizedBox(height: 50),
            Text(
              "Last 7 days attendance",
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 200, child: AttendanceWeeklyChart()),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                showAllStudents(widget.subject);
              },
              label: const Text(
                "View Students",
                style: TextStyle(fontSize: 16),
              ),
              icon: const Icon(Icons.people),
            ),
          ],
        ),
      ),
    );
  }
}
