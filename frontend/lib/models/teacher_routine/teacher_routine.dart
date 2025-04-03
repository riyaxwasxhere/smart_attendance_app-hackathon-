import 'package:frontend/models/teacher_routine/routine_item.dart';

class TeacherRoutine {
  List<RoutineItem> routineData = [];

  void initializeRoutine() {
    routineData = [
      // Session 1: Ended
      RoutineItem(
        title: 'DBMS',
        section: '4-B',
        startTimeString: '3:00 AM',
        endTimeString: '4:00 AM',
      ),
      // Session 2: Ended
      RoutineItem(
        title: 'Operating System',
        section: '4-B',
        startTimeString: '4:00 AM',
        endTimeString: '6:00 AM',
      ),
      // Session 3: Just ended
      RoutineItem(
        title: 'Human Resource',
        section: '4-B',
        startTimeString: '6:00 AM',
        endTimeString: '7:00 AM',
      ),
      // Session 4: Current session
      RoutineItem(
        title: 'Society & Human Culture',
        section: '4-B',
        startTimeString: '7:00 AM',
        endTimeString: '8:00 AM',
      ),
      // Session 5: Upcoming
      RoutineItem(
        title: 'Python',
        section: '4-B',
        startTimeString: '10:00 AM',
        endTimeString: '11:00 AM',
      ),
      // Session 6: Upcoming
      RoutineItem(
        title: 'DBMS lab',
        section: '4-B',
        startTimeString: '11:00 AM',
        endTimeString: '11:30 AM',
      ),
    ];
  }
}
