import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:frontend/widgets/student_widgets/session_tile.dart';
import 'package:frontend/utility/string_to_datetime.dart';
import 'dart:convert';
//for geofencing
// import 'package:smart_attendance/utility/geofencing.dart';
//shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

// final Geofencing geofencing = Geofencing();

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  Map<String, dynamic> studentDetails = {};
  void _showCalender() {
    final today = DateTime.now();
    showDatePicker(context: context, firstDate: today, lastDate: today);
  }

  @override
  void initState() {
    super.initState();
    _getStudentdetails();
  }

  Future<void> _getStudentdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDetailsStr = prefs.getString("user_details");

    if (userDetailsStr != null) {
      studentDetails = Map<String, dynamic>.from(jsonDecode(userDetailsStr));
    }
    setState(() {});
  }

  Future<List<dynamic>> _getTodayClasses() async {
    if (studentDetails.isEmpty || !studentDetails.containsKey('class')) {
      return [];
    }
    final classDetails =
        await FirebaseFirestore.instance
            .collection("classes")
            .doc(studentDetails['class'])
            .get();

    return classDetails.get('monday') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    return FutureBuilder<List<dynamic>>(
      future: _getTodayClasses(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data!.isEmpty) {
          return const Center(child: Text("No classes today"));
        }

        List<dynamic> sessions = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi! Supratik",
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Today's classes",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color.fromARGB(255, 10, 93, 84),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _showCalender,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    final session = sessions[index] as Map;
                    final timeStarted = getDatetimeFromStr(
                      session['start_time'],
                    );
                    final timeEnded = getDatetimeFromStr(session['end_time']);
                    bool ended = currentTime.isAfter(timeEnded);
                    bool current =
                        currentTime.isAfter(timeStarted) &&
                        currentTime.isBefore(timeEnded);
                    return SessionTile(
                      index: index,
                      totalSesssions: sessions.length,
                      session: session,
                      current: current,
                      ended: ended,
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
