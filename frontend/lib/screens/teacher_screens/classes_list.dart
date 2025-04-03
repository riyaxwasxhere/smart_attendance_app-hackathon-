import 'package:flutter/material.dart';
import 'package:frontend/models/assigned_classes/assigned_classes.dart';
import 'package:frontend/screens/teacher_screens/class_summary.dart';
import 'package:frontend/widgets/teacher_widgets/class_card.dart';

class ClassesList extends StatefulWidget {
  const ClassesList({super.key});

  @override
  State<ClassesList> createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesList> {
  final AssignedClasses assignedClasses = AssignedClasses();

  var _currentSem = 4;

  void _selectClass(subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return const ClassSummary();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    assignedClasses.getAssignedClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
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
              itemCount: assignedClasses.classes.length,
              itemBuilder: (ctx, index) {
                final classItem = assignedClasses.classes[index];
                return ClassCard(
                  subject: classItem.subject,
                  semester: classItem.semester,
                  section: classItem.section,
                  onSelectclassItem: _selectClass,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
