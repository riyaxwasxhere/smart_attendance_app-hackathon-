import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/widgets/teacher_widgets/attendance_tile.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key, required this.section});
  final String section;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents(widget.section);
  }

  Future<void> fetchStudents(String section) async {
    final studentsSnapshot =
        await FirebaseFirestore.instance
            .collection("students")
            .where('class', isEqualTo: section)
            .get();

    setState(() {
      students =
          studentsSnapshot.docs.map((doc) {
            final data = doc.data();
            data['is_present'] = false; // Initialize attendance
            return data;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return students.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people),
                  const SizedBox(width: 8),
                  Text(
                    "Attendance for class ${widget.section}",
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    for (var student in students) {
                      if (student['is_in_class'] == true) {
                        student['is_present'] = true;
                      }
                    }
                  });
                },
                label: const Text("Auto Attendance"),
                icon: const Icon(Icons.refresh),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (ctx, index) {
                      final student = students[index];
                      return AttendanceTile(
                        student: student,
                        isPresent: student['is_present'],
                        onChanged: (val) {
                          setState(() {
                            students[index]['is_present'] = val;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Submit attendance logic here
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: const Text("Submit"),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.error.withAlpha(180),
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
