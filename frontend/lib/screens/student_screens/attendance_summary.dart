import 'package:flutter/material.dart';
import 'package:frontend/widgets/student_widgets/bar_graph.dart';

class AttendaceSummary extends StatelessWidget {
  const AttendaceSummary({
    super.key,
    required this.subjectName,
    this.studentId,
  });

  final String subjectName;
  final String? studentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Report"),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Subject: $subjectName",
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            DropdownButton(
              value: 'Last 30 Days',
              items:
                  ['Today', 'Last 7 Days', 'Last 30 Days', 'This Semester']
                      .map(
                        (item) =>
                            DropdownMenuItem(value: item, child: Text(item)),
                      )
                      .toList(),
              onChanged: (v) {},
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blue,
                size: 30,
              ), // Custom dropdown icon
              dropdownColor:
                  Colors.white, // Background color of the dropdown menu
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ), // Selected text style

              borderRadius: BorderRadius.circular(12),
            ),

            const SizedBox(height: 32),
            const SizedBox(
              height: 400,
              child: BarGraph(totalDays: 30, daysPresent: 20, daysAbsent: 10),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: const Column(
                      children: [
                        Text("TOTAL", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text(
                          "30 Days",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: const Column(
                      children: [
                        Text("PRESENT", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text(
                          "20 Days",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: const Column(
                      children: [
                        Text("ABSENT", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 8),
                        Text(
                          "10 Days",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Text(
                  "Days Present: ${(20 / 30 * 100).toStringAsFixed(2)}%",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Days Absent: ${(10 / 30 * 100).toStringAsFixed(2)}%",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Attendance quality: Average 😐",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
