import 'package:flutter/material.dart';
import 'package:frontend/screens/admin_screens/day_row.dart';

class AddRoutine extends StatefulWidget {
  const AddRoutine({super.key});

  @override
  State<AddRoutine> createState() => _AddRoutineState();
}

class _AddRoutineState extends State<AddRoutine> {
  final _formKey = GlobalKey<FormState>();
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  Map<String, List<Map<String, String>>> schedule = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
  };

  var _selectedSemester = '1';
  final _sectionController = TextEditingController();

  // List<dynamic> teachers = [];

  void addClass(String day, Map<String, String> classDetails) {
    setState(() {
      schedule[day]!.add(classDetails);
    });
  }

  void _validateAndAddRoutine() async {
    if (!_formKey.currentState!.validate()) return;

    for (final day in schedule.keys) {
      for (final session in schedule[day]!) {
        final teacherId = session['teacherId'];

        var url = Uri.parse(
          "https://smart-attendance-app-hackathon.onrender.com/api/routine",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: ListView(
        children: [
          ...days.map((day) {
            return DayRow(
              day: day,
              classes: schedule[day]!,
              onAddClass: addClass,
            );
          }),
          const SizedBox(height: 32),
          Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Semester',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedSemester,
                  items: List.generate(8, (index) {
                    return DropdownMenuItem(
                      value: (index + 1).toString(),
                      child: Text((index + 1).toString()),
                    );
                  }),
                  onChanged: (value) {
                    if (value == null) return;
                    _selectedSemester = value;
                  },
                  validator:
                      (value) =>
                          value == null ? 'Please select a number' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _sectionController,
                  decoration: const InputDecoration(
                    labelText: "section",
                    hintText: "Enter your section",
                    prefixIcon: Icon(Icons.door_back_door),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please add a section";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                MaterialButton(
                  onPressed: _validateAndAddRoutine,
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Colors.white,
                  minWidth: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: Text("Add Routine", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
