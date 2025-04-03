import 'package:flutter/material.dart';
import 'package:frontend/models/teacher_routine/routine_item.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TeacherClassTile extends StatelessWidget {
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
  final void Function(String section) onShowAttendance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.05,
      isFirst: index == 0,
      isLast: index == totalSesssions - 1,
      indicatorStyle: IndicatorStyle(
        width: current ? 18.0 : 15.0,
        color:
            current
                ? const Color.fromARGB(255, 74, 222, 143)
                : (ended
                    ? Colors.grey
                    : const Color.fromARGB(255, 183, 235, 230)),
      ),
      beforeLineStyle: LineStyle(color: ended ? Colors.grey : Colors.teal),
      endChild: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ended ? Colors.grey.shade300 : Colors.white,
          border: Border.all(
            color: current ? Colors.teal : Colors.grey,
            width: current ? 2 : 1,
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
                    "${session.startTimeString} - ${session.endTimeString}",
                    style: TextStyle(
                      fontWeight: current ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    session.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: current ? FontWeight.bold : FontWeight.normal,
                      color: ended ? Colors.grey : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text("class: ${session.section}", style: theme.textTheme.bodyLarge),
            const SizedBox(height: 16),
            if (current || ended)
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
                    ended
                        ? null
                        : () {
                          onShowAttendance(session.section);
                        },
                label: const Text("Give attendance"),
              ),
            if (!ended && !current)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: theme.colorScheme.error.withAlpha(180),
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                onPressed: () {},
                label: const Text("Cancel class"),
                icon: const Icon(Icons.cancel),
              ),
          ],
        ),
      ),
    );
  }
}
