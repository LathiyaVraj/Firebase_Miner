import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationHelpers {
  LocalNotificationHelpers._();

  static final LocalNotificationHelpers localNotificationHelpers =
      LocalNotificationHelpers._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> sendSimpleNotification(
      {required String name, required String operation}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("Demo ID", "Dhruvin Channel",
            importance: Importance.max, priority: Priority.max);
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        1, "$name record $operation", "Dummy content", notificationDetails,
        payload: "This is the simple notification Payload");
  }

  sendScheduledNotification(
      {required String name, required String opration}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("Demo ID", "Dhruvin Channel",
            importance: Importance.high, priority: Priority.high);
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        "$name record $opration",
        "Dummy content",
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 3)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
