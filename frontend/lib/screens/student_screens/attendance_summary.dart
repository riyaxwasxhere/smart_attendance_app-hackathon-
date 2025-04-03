import 'package:flutter/material.dart';

class AttendanceSummary extends StatefulWidget {
  const AttendanceSummary({super.key, required this.studentId});

  final String studentId;

  @override
  State<AttendanceSummary> createState() => _AttendanceSummaryState();
}

class _AttendanceSummaryState extends State<AttendanceSummary> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
