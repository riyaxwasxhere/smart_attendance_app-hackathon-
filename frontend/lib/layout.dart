import 'package:flutter/material.dart';
import 'package:frontend/screens/teacher_screens/classes_list.dart';
import 'package:frontend/screens/teacher_screens/teacher_dashboard.dart';

final List<Map<String, dynamic>> _teacherScreens = [
  {
    'widget': const TeacherDashboard(),
    'title': 'Dashboard',
    'icon': const Icon(Icons.home),
  },
  {
    'widget': const ClassesList(),
    'title': 'Classes',
    'icon': const Icon(Icons.analytics),
  },
];

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentScreen = _teacherScreens[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentScreen['title'],
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: currentScreen['widget'],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (final screen in _teacherScreens)
            BottomNavigationBarItem(
              icon: screen['icon'],
              label: screen['title'],
            ),
        ],
        currentIndex: _currentIndex,
        onTap:
            (value) => setState(() {
              _currentIndex = value;
            }),
      ),
    );
  }
}
