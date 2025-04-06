import 'package:flutter/material.dart';

class AttendanceTile extends StatelessWidget {
  const AttendanceTile({
    super.key,
    required this.student,
    required this.isPresent,
    required this.onChanged,
  });

  final Map<String, dynamic> student;
  final bool isPresent;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    final name = student['name'];
    final roll = student['roll'].toString();
    final isInClass = student['is_in_class'];

    return Opacity(
      opacity: isInClass ? 1.0 : 0.5,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${roll.substring(roll.length - 3)}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16),
                  Text("$name", style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              Checkbox(
                value: isPresent,
                onChanged: isInClass ? onChanged : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
