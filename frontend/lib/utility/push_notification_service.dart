import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

import 'dart:convert';

class PushNotificationService {
  static Future<String> _getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "smart-attendance-7b79f",
      "private_key_id": "12c8d791e40905215a39b8db9ac22e0b2ec2d1ae",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCjFcwdFBgTsdOB\nV55j25OiA9bLKzT2XpHrPDl3rWZMiCbpiAnURst+LdlksNjyBN0q+z+Ia0C4c4tH\neWCWUHUnOuU9YlkcqsqvNUur731atlERzjtqlK8g+bCf6olfUtPDazeEjZzYGNAl\ndqWtk73wTzQTk/t73+gcA+GiBhw1+3hTnGTJfKBC52gGV6qaLHoN5TtfE35PTGlb\nYksNOhipz1dUXqBTj7/GK1GGP7XC7um7Ie9hHvHsg1kXTxdt70P+WxPeF1ZRa/MO\nY7LYlV7/P4u1rzYAQdoBdOMT39ksVWXQZX16EcfplpjSXy+DXVwavpD/w0xUNXsi\nwuwn8/ijAgMBAAECggEACK707slunMHXqqfhKZz75+D/c1LqH4Iaj+Vlg+9KJqIL\nPFz/dPuOAzpqvFdEPeKvagX1tIxNZmTUkiouz+IZ0sxqf1G4v/OCFkEmtdFrIcTa\nXTHXbQ3co0tYMbOZu+cbmmifjKHDq6fqkUwXdz4KG30EH1S+S7K416EHRwq/Psp+\nkCMTwmEcIwVEjM3rHuqDHGlHLx6RJcAmRIKsyRxQ/0avjxR0uLeu93hxdS62GrRG\nYeFS1ShWiB0UZMjyl9GKLEOQ6bgRjVjx+mAGZj3wQcE0lYUM0IzdxPuc2q4nT5ig\nRcwR4UWM6glEa3c7czuYiwkZQN8EtO+zgxX6KGAnEQKBgQDkzrgY12KI/f6MlWBW\nZt33g4jZ1cb6EKVkmg1ez7EflC2PD4c1oz+cmQ/cvgmg3gBxBWiL4fUhEK81NW94\nnbMLBGbKbdHyB9fFXNpD43F+h60PttvWWaYgZLW2H8XPHql3PPDLonoItnMMu+Nc\n9wcJhC8MeNxdhH9MnC8WFj3qMQKBgQC2d4eJbVMXvIjuEfajMBGnQ6Wp4TS6N3Dp\nfTfsOCwNCE2cRLGTdz5evFF+RfrIh5YGsUVGtAJCZDPEqsoiTAaFgiKQ34b+uPsL\n0CEEj80WqwoBIfTpo5+zKtwE6Zw482AoWt4teGjRUGW5TIqAT5bcnGHwJxH0WoVm\nL+ZjaehHEwKBgBkT6yuV18/p/s9Lw/5UUfnB6eruOlvIHUiUdeixXNl4NTIb4pbn\naJ5yTEHGdmmyS1wX2qiSQHq6SGnNjIUsy6XmepmvRbaAU47nKWkNcbALkNVLFnc8\n5i9gumXWv6h+1NYj0MSQ700rKhr4MOhMjvHlEf8M9CIv1oAAEk0abPjRAoGAZEAB\n2JCXMZhlRx/ZeUlEubhiAZb5KEKjp7Ujj4ZBNZvVQEFBqzq9qsEeqRj7s0dDN0QY\nQsNN5no1Mx1+1x8cCig4o44cFkE9tPzR1zbGwGiSo5Krg95hNMgcgBp1uZiFwUZD\ngYoBVNcuPIOAKQURZv4IlTByHeXKGx3AH+ilNL8CgYBp7pYsV/dTzEYXYfsxJozn\nvSwV/HIcipE8BCqW1unHw1gt3BYwjgvxjjl7kW10b3spRrW/td5nb7k6DeBtzGKm\nZyI6xHVeg73uL1ypodasjLi0dpwIrwlpu9Z6p1qCXcqRqv0yKeNZMFvB4VlZuEzw\nqvOZur+kZVqNx4hmoe0Q0Q==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "flutter-smart-attendance@smart-attendance-7b79f.iam.gserviceaccount.com",
      "client_id": "104984460478467743615",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/flutter-smart-attendance%40smart-attendance-7b79f.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials = await auth
        .obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
          scopes,
          client,
        );

    client.close();

    return credentials.accessToken.data;

    //get the access token
  }

  static sendNotificationToSelectedStudents(List<String> tokens) async {
    final String serverAccessToken = await _getAccessToken();
    String endpointFirebaseCloudMessaging =
        "https://fcm.googleapis.com/v1/projects/smart-attendance-7b79f/messages:send";

    for (final token in tokens) {
      final Map<String, dynamic> message = {
        'message': {
          'token': token,
          'notification': {
            'title': "Class alert!",
            'body': "Your teacher has entered the class!",
          },
        },
      };
      final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $serverAccessToken",
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print("notification sent successfully!");
      } else {
        print("failed to send FCM message : ${response.statusCode}");
      }
    }
  }
}
