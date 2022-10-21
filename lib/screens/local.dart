import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();
  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/notification');
    const InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    return const NotificationDetails(android: androidNotificationDetails);
  }

  Future<void> showNotification({
    required int uid,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(uid, title, body, details);
  }

  Future<void> showScheduledNotification(
      {required int uid,
      required String title,
      required String body,
      required int seconds}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
        uid,
        title,
        body,
        tz.TZDateTime.from(
          DateTime.now().add(Duration(seconds: seconds)),
          tz.local,
        ),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    // ignore: avoid_print
    print('id $id');
  }

  void onSelectNotification(String? payload) {
    // ignore: avoid_print
    print('payload $payload');
  }
}
