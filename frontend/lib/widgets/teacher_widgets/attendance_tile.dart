import 'package:flutter/material.dart';

class AttendanceTile extends StatefulWidget {
  const AttendanceTile({super.key, required this.student});
  final Map<String, dynamic> student;

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  bool isPresent = false;

  @override
  Widget build(BuildContext context) {
    final firstName = widget.student['student_firstname'];
    final lastName = widget.student['student_lastname'];
    final roll = widget.student['roll'].toString();
    final isInClass = widget.student['is_in_class'];
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
                  Text(
                    "$firstName $lastName",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),

              Checkbox(
                value: isPresent,
                onChanged:
                    isInClass
                        ? (v) {
                          if (v == null) return;
                          setState(() {
                            isPresent = v;
                          });
                        }
                        : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
