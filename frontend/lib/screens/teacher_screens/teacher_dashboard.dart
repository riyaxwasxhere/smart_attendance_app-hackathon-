import 'package:flutter/material.dart';
//teacher routine
import 'package:frontend/models/teacher_routine/teacher_routine.dart';
import 'package:frontend/widgets/teacher_widgets/teacher_class_tile.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  showAttendanceModal(String str) {}

  @override
  Widget build(BuildContext context) {
    TeacherRoutine routine = TeacherRoutine();
    routine.initializeRoutine();
    final sessions = routine.routineData;
    final theme = Theme.of(context);
    final currentTime = DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hi! Teacher", style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          Text(
            "Today's classes",
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (ctx, index) {
                final session = sessions[index];
                final startTime = session.startTime;
                final endTime = session.endTime;

                bool ended = currentTime.isAfter(endTime);
                bool current =
                    currentTime.isAfter(startTime) &&
                    currentTime.isBefore(endTime);

                return TeacherClassTile(
                  onShowAttendance: showAttendanceModal,
                  session: session,
                  ended: ended,
                  current: current,
                  index: index,
                  totalSesssions: sessions.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
