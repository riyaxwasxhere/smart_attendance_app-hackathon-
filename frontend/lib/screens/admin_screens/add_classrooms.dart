import 'package:flutter/material.dart';
import 'package:frontend/utility/geofencing.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddClassrooms extends StatefulWidget {
  const AddClassrooms({super.key});

  @override
  State<AddClassrooms> createState() => _AddClassroomsState();
}

class _AddClassroomsState extends State<AddClassrooms> {
  final _formKey = GlobalKey<FormState>();
  final _sectionController = TextEditingController();
  final _deptController = TextEditingController();
  var _selectedSemester = '1';

  double latitude = 0;
  double longitude = 0;

  Future<void> getGeoCoords() async {
    Geofencing geofencing = Geofencing();
    var pos = await geofencing.determinePosition();
    setState(() {
      latitude = pos.latitude;
      longitude = pos.longitude;
    });
  }

  void showSnackBar() {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success!!',
        message: 'Successfully added the class',
        contentType: ContentType.success,
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<void> validateAndAddClass() async {
    if (!_formKey.currentState!.validate()) return;
    var url = Uri.parse(
      "https://smart-attendance-app-hackathon.onrender.com/api/geofence",
    );

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "className": "$_selectedSemester-${_sectionController.text}",
          "dept": _deptController.text,
          "location": {
            'type': 'Point',
            'coordinates': [longitude, latitude],
          },
        }),
      );

      if (response.statusCode == 201) {
        showSnackBar();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
      child: Column(
        children: [
          Text(
            "Add the details for the classroom ",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 32),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _deptController,
                  decoration: const InputDecoration(
                    labelText: "Dept",
                    hintText: "Enter department name",
                    prefixIcon: Icon(Icons.apartment),
                    border: OutlineInputBorder(),
                  ),
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
                const SizedBox(height: 32),
                Text(
                  "Latitude: $latitude",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  "Longitude: $longitude",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: getGeoCoords,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 19, 85, 79),
                    foregroundColor: Colors.white,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  icon: const Icon(Icons.pin_drop),
                  label: const Text("Get geocoordinates"),
                ),
                const SizedBox(height: 16),
                MaterialButton(
                  onPressed: validateAndAddClass,
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Colors.white,
                  minWidth: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: Text(
                      "Add ClassRoom",
                      style: TextStyle(fontSize: 20),
                    ),
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
