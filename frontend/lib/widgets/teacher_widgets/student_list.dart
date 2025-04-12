import 'package:flutter/material.dart';
import 'package:frontend/screens/student_screens/attendance_summary.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentList extends StatefulWidget {
  const StudentList({super.key, required this.subject});

  final String subject;

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late Future<List<dynamic>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = fetchStudents(); // properly assign the future
  }

  Future<List<dynamic>> fetchStudents() async {
    final url = Uri.parse(
      "https://smart-attendance-app-hackathon.onrender.com/api/students/BCA/4-B",
    );

    final res = await http.get(url);

    if (res.statusCode == 200) {
      return jsonDecode(res.body); // Return the decoded list of students
    } else {
      throw Exception('Failed to load students');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<List<dynamic>>(
      future: _studentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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
                        subtitle: Text("Roll No: ${student["roll"]}"),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AttendaceSummary(
                                      studentId: student["id"],
                                      subjectName: widget.subject,
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
