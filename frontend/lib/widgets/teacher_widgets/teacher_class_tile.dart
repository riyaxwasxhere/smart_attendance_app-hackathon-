import 'package:flutter/material.dart';
import 'package:frontend/models/teacher_routine/routine_item.dart';
import 'package:frontend/utility/push_notification_service.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:frontend/utility/geofencing.dart';

class TeacherClassTile extends StatefulWidget {
  const TeacherClassTile({
    super.key,
    required this.index,
    required this.totalSesssions,
    required this.session,
    required this.current,
    required this.ended,
    required this.onShowAttendance,
  });

  final int index;
  final int totalSesssions;
  final RoutineItem session;
  final bool current;
  final bool ended;
  final void Function(String section, String subject) onShowAttendance;

  @override
  State<TeacherClassTile> createState() => _TeacherClassTileState();
}

class _TeacherClassTileState extends State<TeacherClassTile> {
  bool classStarted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.05,
      isFirst: widget.index == 0,
      isLast: widget.index == widget.totalSesssions - 1,
      indicatorStyle: IndicatorStyle(
        width: widget.current ? 18.0 : 15.0,
        color:
            widget.current
                ? const Color.fromARGB(255, 74, 222, 143)
                : (widget.ended
                    ? Colors.grey
                    : const Color.fromARGB(255, 183, 235, 230)),
      ),
      beforeLineStyle: LineStyle(
        color: widget.ended ? Colors.grey : Colors.teal,
      ),
      endChild: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.ended ? Colors.grey.shade300 : Colors.white,
          border: Border.all(
            color: widget.current ? Colors.teal : Colors.grey,
            width: widget.current ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    "${widget.session.startTimeString} - ${widget.session.endTimeString}",
                    style: TextStyle(
                      fontWeight:
                          widget.current ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.session.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          widget.current ? FontWeight.bold : FontWeight.normal,
                      color: widget.ended ? Colors.grey : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "class: ${widget.session.section}",
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),

            //start class button
            if (widget.current && !classStarted)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: const Color.fromARGB(255, 34, 119, 42),
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                onPressed: () async {
                  // List<String> tokens = await getStudentTokens(
                  //   widget.session.dept,
                  //   widget.session.section,
                  // );
                  // PushNotificationService.sendNotificationToSelectedStudents(
                  //   tokens,
                  // );
                  setState(() {
                    classStarted = true;
                  });
                },
                child: const Text("Start class"),
              ),

            const SizedBox(height: 16),
            //give attendance button
            if (widget.current || widget.ended)
              ElevatedButton.icon(
                icon: const Icon(Icons.people),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                onPressed:
                    widget.ended || !classStarted
                        ? null
                        : () {
                          widget.onShowAttendance(
                            widget.session.section,
                            widget.session.title,
                          );
                        },
                label: const Text("Give attendance"),
              ),
            if (!widget.ended && !widget.current)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: theme.colorScheme.error.withAlpha(180),
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                onPressed: () {
                  // Cancel class logic (can be added later)
                },
                label: const Text("Cancel class"),
                icon: const Icon(Icons.cancel),
              ),
          ],
        ),
      ),
    );
  }
}
