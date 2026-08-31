import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  static const int _reminderId = 1001;

  static const NotificationDetails _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'daily_reminder',
      'Daily Reminder',
      channelDescription: 'Reminder to capture your daily minute',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  FlutterLocalNotificationsPlugin get plugin => _plugin;

  Future<void> init() async {
    if (_initialized) return;

    tzdata.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {},
    );

    await _requestPermissions();
    _initialized = true;
  }

  Future<void> _requestPermissions() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> scheduleDailyReminder(TimeOfDay time) async {
    await _ensureTimezone();

    final now = tz.TZDateTime.now(tz.local);
    final scheduled = _nextInstanceOf(time, now);

    await _plugin.zonedSchedule(
      id: _reminderId,
      title: 'One Minute',
      body: "It's time to capture your moment.",
      scheduledDate: scheduled,
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelReminder() async {
    await _plugin.cancel(id: _reminderId);
  }

  Future<void> showNow() async {
    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: 'One Minute',
      body: 'Test notification - it works!',
      notificationDetails: _details,
    );
  }

  Future<void> _ensureTimezone() async {
    if (tz.local.name == 'UTC') {
      final name = await FlutterTimezone.getLocalTimezone();
      try {
        tz.setLocalLocation(tz.getLocation(name));
      } catch (_) {}
    }
  }

  tz.TZDateTime _nextInstanceOf(TimeOfDay time, tz.TZDateTime now) {
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
