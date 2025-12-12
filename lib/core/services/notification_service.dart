import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static int _idCounter = 0;

  static int generateId() {
    return _idCounter++;
  }

  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null, // Use app icon
      [
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Reminders',
          channelDescription: 'Notifications for scheduled visits',
          importance: NotificationImportance.Max,
          channelShowBadge: true,

        ),
      ],
      debug: true,
    );
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime date,
    required TimeOfDay time,
  }) async {
    final scheduledDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        year: scheduledDate.year,
        month: scheduledDate.month,
        day: scheduledDate.day,
        hour: scheduledDate.hour,
        minute: scheduledDate.minute,
        second: 0,
        millisecond: 0,
        preciseAlarm: true, // مهم جداً عشان يشتغل بعد غلق التطبيق
        repeats: false, // عايزها مره واحدة فقط
      ),
    );
  }
}
