import 'package:flutter/material.dart';
import 'package:frontend/screens/student_screens/attendance_summary.dart';
import 'package:frontend/widgets/student_widgets/subject_card.dart';

class SubjectsSummary extends StatefulWidget {
  const SubjectsSummary({super.key});

  @override
  State<SubjectsSummary> createState() => _SubjectsSummaryState();
}

class _SubjectsSummaryState extends State<SubjectsSummary> {
  final List<String> _subjects = const [
    'DBMS',
    'Operating System',
    'Society and Human Behaviour',
    'Human Resource Management',
    'DBMS Lab',
    'Software Engineering',
  ];

  var _currentSem = 4;

  void _selectSubject(subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return AttendaceSummary(subjectName: subject);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton(
            value: _currentSem,
            items: const [
              DropdownMenuItem(value: 1, child: Text("SEM1")),
              DropdownMenuItem(value: 2, child: Text("SEM2")),
              DropdownMenuItem(value: 3, child: Text("SEM3")),
              DropdownMenuItem(value: 4, child: Text("SEM4")),
            ],
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _currentSem = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: _subjects.length,
              itemBuilder: (ctx, index) {
                final subject = _subjects[index];
                return SubjectCard(
                  subject: subject,
                  onSelectSubject: _selectSubject,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
