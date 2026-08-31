import 'package:flutter/material.dart';
import 'package:oneminute/core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderProvider extends ChangeNotifier {
  static const String _enabledKey = 'reminder_enabled';
  static const String _hourKey = 'reminder_hour';
  static const String _minuteKey = 'reminder_minute';

  bool _isEnabled;
  TimeOfDay _time;

  ReminderProvider({bool isEnabled = false, TimeOfDay? time})
      : _isEnabled = isEnabled,
        _time = time ?? const TimeOfDay(hour: 21, minute: 0) {
    _load();
  }

  bool get isEnabled => _isEnabled;
  TimeOfDay get time => _time;

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_enabledKey) ?? _isEnabled;
    final hour = prefs.getInt(_hourKey) ?? _time.hour;
    final minute = prefs.getInt(_minuteKey) ?? _time.minute;
    _isEnabled = enabled;
    _time = TimeOfDay(hour: hour, minute: minute);

    if (_isEnabled) {
      await NotificationService.instance.scheduleDailyReminder(_time);
    }
    notifyListeners();
  }

  Future<void> setEnabled(bool value) async {
    _isEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, value);

    if (value) {
      await NotificationService.instance.scheduleDailyReminder(_time);
    } else {
      await NotificationService.instance.cancelReminder();
    }
    notifyListeners();
  }

  Future<void> setTime(TimeOfDay time) async {
    _time = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_hourKey, time.hour);
    await prefs.setInt(_minuteKey, time.minute);

    if (_isEnabled) {
      await NotificationService.instance.scheduleDailyReminder(_time);
    }
    notifyListeners();
  }
}
