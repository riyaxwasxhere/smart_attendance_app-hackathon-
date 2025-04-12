import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _sectionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var _selectedDepartment = "BCA";
  var _selectedSemester = '4';

  void showSnackBar() {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success!!',
        message: 'Successfully added the student',
        contentType: ContentType.success,
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<void> validateAndAddStudent() async {
    if (!_formKey.currentState!.validate()) return;
    var fullname = _nameController.text;
    var roll = int.parse(_rollController.text);
    var email = _emailController.text;
    var password = _passwordController.text;
    var dept = _selectedDepartment;
    var className = "$_selectedSemester-${_sectionController.text}";

    var url = Uri.parse(
      "https://smart-attendance-app-hackathon.onrender.com/api/students/signup",
    );

    if (!mounted) return;
    FocusScope.of(context).unfocus();

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": fullname,
        "roll": roll,
        "email": email,
        "password": password,
        "dept": dept,
        "className": className,
      }),
    );

    if (response.statusCode == 200) {
      List<TextEditingController> controllers = [
        _nameController,
        _rollController,
        _emailController,
        _passwordController,
        _confirmPasswordController,
        _sectionController,
      ];

      for (final controller in controllers) {
        controller.clear();
      }

      _selectedDepartment = "BCA";
      _selectedSemester = "4";

      showSnackBar();
    } else {
      print(jsonDecode(response.body).message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        child: Column(
          children: [
            Text(
              "Fill the details of the student",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Full name",
                      hintText: "Enter student name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter a name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _rollController,
                    decoration: const InputDecoration(
                      labelText: "Roll number",
                      hintText: "Enter student roll",
                      prefixIcon: Icon(Icons.numbers),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter roll number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter email";
                      if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      hintText: "Enter password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Please enter password";
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: "Confirm password",
                      hintText: "Confirm your password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm password";
                      }
                      if (value != _passwordController.text) {
                        return "Passwords do not match!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Department',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedDepartment,
                    items:
                        ['BCA', 'BBA', 'Btech CSE', 'MCA']
                            .map(
                              (dept) => DropdownMenuItem(
                                value: dept,
                                child: Text(dept),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      _selectedDepartment = value;
                    },
                    validator:
                        (value) =>
                            value == null ? 'Please select a department' : null,
                  ),
                  const SizedBox(height: 16),
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
                    onPressed: validateAndAddStudent,
                    color: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    minWidth: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                      child: Text(
                        "Add Student",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
