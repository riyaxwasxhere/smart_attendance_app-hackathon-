import 'package:frontend/models/teacher_routine/routine_item.dart';

class TeacherRoutine {
  List<RoutineItem> routineData = [];

  void initializeRoutine() {
    routineData = [
      // Session 1: Ended
      RoutineItem(
        title: 'DBMS',
        section: '4-B',
        startTimeString: '5:00 PM',
        endTimeString: '5:30 PM',
      ),
      // Session 2: Ended
      RoutineItem(
        title: 'Operating System',
        section: '4-B',
        startTimeString: '5:30 PM',
        endTimeString: '6:00 PM',
      ),
      // Session 3: Just ended
      RoutineItem(
        title: 'Human Resource',
        section: '4-B',
        startTimeString: '7:00 PM',
        endTimeString: '8:00 PM',
      ),
      // Session 4: Current session
      RoutineItem(
        title: 'Society & Human Culture',
        section: '4-B',
        startTimeString: '8:00 PM',
        endTimeString: '9:00 PM',
      ),
      // Session 5: Upcoming
      RoutineItem(
        title: 'Python',
        section: '4-B',
        startTimeString: '9:00 PM',
        endTimeString: '10:00 PM',
      ),
      // Session 6: Upcoming
      RoutineItem(
        title: 'DBMS lab',
        section: '4-B',
        startTimeString: '11:00 PM',
        endTimeString: '12:00 AM',
      ),
    ];
  }
}
