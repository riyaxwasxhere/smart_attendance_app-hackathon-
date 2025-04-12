import 'package:flutter/material.dart';
import 'package:frontend/screens/admin_screens/add_routine_modal.dart';

class DayRow extends StatelessWidget {
  const DayRow({
    super.key,
    required this.day,
    required this.classes,
    required this.onAddClass,
  });

  final String day;
  final List<Map<String, String>> classes;
  final void Function(String day, Map<String, String> classDetails) onAddClass;

  void _showAddSubjectDialog(BuildContext context, String day) {
    showDialog(
      context: context,
      builder: (context) {
        return AddRoutineModal(day: day, onAddClass: onAddClass);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 90,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      classes.asMap().entries.map((entry) {
                        final details = entry.value;
                        final index = entry.key;
                        return Padding(
                          padding:
                              index == 0
                                  ? const EdgeInsets.only(right: 8)
                                  : const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  details['subject']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text("${details['start']} - ${details['end']}"),
                                const SizedBox(height: 8),
                                Text(details['teacherName']!),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                _showAddSubjectDialog(context, day);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
