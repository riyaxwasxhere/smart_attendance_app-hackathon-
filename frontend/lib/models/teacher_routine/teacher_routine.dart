import 'package:frontend/models/teacher_routine/routine_item.dart';

class TeacherRoutine {
  List<RoutineItem> routineData = [];

  void initializeRoutine() {
    routineData = [
      // Session 1: Ended
      RoutineItem(
        title: 'DBMS',
        section: '1-B',
        startTimeString: '10:00 AM',
        endTimeString: '10:30 AM',
        dept: "BCA",
      ),
      // Session 2: Ended
      RoutineItem(
        title: 'Operating System',
        section: '1-B',
        startTimeString: '11:00 AM',
        endTimeString: '12:00 PM',
        dept: "BCA",
      ),
      // Session 3: Just ended
      RoutineItem(
        title: 'Human Resource',
        section: '1-B',
        startTimeString: '12:00 PM',
        endTimeString: '2:00 PM',
        dept: "BCA",
      ),
      // Session 4: Current session
      RoutineItem(
        title: 'Society & Human Culture',
        section: '1-B',
        startTimeString: '2:00 PM',
        endTimeString: '4:00 PM',
        dept: "BCA",
      ),
      // Session 5: Upcoming
      RoutineItem(
        title: 'Python',
        section: '1-B',
        startTimeString: '4:00 PM',
        endTimeString: '6:00 PM',
        dept: "BCA",
      ),
      // Session 6: Upcoming
      RoutineItem(
        title: 'DBMS lab',
        section: '1-B',
        startTimeString: '8:00 PM',
        endTimeString: '10:30 PM',
        dept: "BCA",
      ),
    ];
  }
}
