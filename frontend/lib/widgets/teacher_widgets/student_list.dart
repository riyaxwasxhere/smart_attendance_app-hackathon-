import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/screens/student_screens/attendance_summary.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late Future<List<Map<String, dynamic>>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = fetchStudents();
  }

  // Function to fetch students from Firestore
  Future<List<Map<String, dynamic>>> fetchStudents() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('students').get();

      return snapshot.docs.map((doc) {
        return {
          "name": doc["student_firstname"],
          "rollNumber": doc["roll"],
          "id": doc.id, // Store document ID for reference
        };
      }).toList();
    } catch (e) {
      print("Error fetching students: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _studentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          ); // Loading spinner
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error fetching data"));
        }

        final students = snapshot.data ?? [];

        if (students.isEmpty) {
          return const Center(child: Text("No students found"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, size: 30),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.people),
                  const SizedBox(width: 6),
                  Text("List of Students:", style: theme.textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: ListTile(
                        title: Text(student["name"]),
                        subtitle: Text("Roll No: ${student["rollNumber"]}"),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AttendanceSummary(
                                      studentId: student["id"],
                                    ),
                              ),
                            );
                          },
                          child: const Text("View Attendance"),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Placeholder Attendance Screen
class AttendanceScreen extends StatelessWidget {
  final String studentId;

  AttendanceScreen({required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance Details")),
      body: Center(
        child: Text("Attendance details for Student ID: $studentId"),
      ),
    );
  }
}
