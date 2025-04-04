import 'package:frontend/models/assigned_classes/assigned_class.dart';

class AssignedClasses {
  List<AssignedClass> classes = [];

  void getAssignedClasses() {
    //call api(TODO)
    classes = [
      AssignedClass(section: "B", semester: "4", subject: "DBMS", dept: "BCA"),
      AssignedClass(section: "C", semester: "4", subject: "DBMS", dept: "BCA"),
      AssignedClass(
        section: "C",
        semester: "5",
        subject: "Operating System",
        dept: "BCA",
      ),
      AssignedClass(
        section: "A",
        semester: "1",
        subject: "Python",
        dept: "BCA",
      ),
      AssignedClass(
        section: "B",
        semester: "1",
        subject: "Python",
        dept: "BCA",
      ),
    ];
  }
}
