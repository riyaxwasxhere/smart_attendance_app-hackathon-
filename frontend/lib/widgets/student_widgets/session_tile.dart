import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({
    super.key,
    required this.index,
    required this.totalSesssions,
    required this.session,
    required this.current,
    required this.ended,
  });

  final int index;
  final int totalSesssions;
  final Map session;
  final bool current;
  final bool ended;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.05,
      isFirst: index == 0,
      isLast: index == totalSesssions - 1,
      indicatorStyle: IndicatorStyle(
        width: current ? 18.0 : 15.0,
        color:
            current
                ? Colors.teal
                : (ended
                    ? Colors.grey
                    : const Color.fromARGB(255, 134, 233, 223)),
      ),
      beforeLineStyle: LineStyle(
        color: ended ? Colors.grey : const Color.fromARGB(255, 23, 53, 50),
      ),
      endChild: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ended ? Colors.grey.shade300 : Colors.white,
          border: Border.all(color: current ? Colors.teal : Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                "${session['start_time']} ${session['end_time']}",
                style: TextStyle(
                  fontWeight: current ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                session['subject_name'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: current ? FontWeight.bold : FontWeight.normal,
                  color: ended ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
