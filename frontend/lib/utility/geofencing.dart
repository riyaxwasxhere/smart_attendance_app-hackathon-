import 'package:flutter/material.dart';
import 'package:native_geofence/native_geofence.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

@pragma('vm:entry-point')
Future<void> geofenceTriggered(GeofenceCallbackParams params) async {
  NativeGeofenceBackgroundManager.instance.promoteToForeground();

  NativeGeofenceBackgroundManager.instance.demoteToBackground();
}

Future<List<String>> getStudentTokens(String dept, String className) async {
  debugPrint("Fetching student tokens for dept: $dept, class: $className");

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance
          .collection('students')
          .where('dept', isEqualTo: dept)
          .where('class', isEqualTo: className)
          .get();
  debugPrint("Query returned ${querySnapshot.docs.length} documents");
  List<String> tokens =
      querySnapshot.docs
          .map((doc) => doc['fcmToken'] as String)
          .where((token) => token.isNotEmpty) // Remove empty tokens
          .toList();
  debugPrint("Extracted tokens: $tokens");
  return tokens;
}

class Geofencing {
  Future<void> initGeofencing() async {
    await NativeGeofenceManager.instance.initialize();
  }

  Future<void> removeAllGeofences() async {
    await NativeGeofenceManager.instance.removeAllGeofences();
  }

  Future<void> createGeofence(coords, String dept, String classroom) async {
    //define the geofence
    final zone = Geofence(
      id: "$dept--$classroom",
      location: Location(
        latitude: coords.latitude,
        longitude: coords.longitude,
      ),
      radiusMeters: 50,
      triggers: {GeofenceEvent.enter, GeofenceEvent.exit},
      iosSettings: const IosGeofenceSettings(initialTrigger: true),
      androidSettings: const AndroidGeofenceSettings(
        initialTriggers: {GeofenceEvent.enter},
        expiration: Duration(days: 7),
        notificationResponsiveness: Duration(seconds: 30),
      ),
    );

    //create geofence
    await NativeGeofenceManager.instance.createGeofence(
      zone,
      geofenceTriggered,
    );
  }

  Future<void> getTotalGeofences() async {
    final List<ActiveGeofence> myGeofences =
        await NativeGeofenceManager.instance.getRegisteredGeofences();
    print('There are ${myGeofences.length} active geofences.');
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
