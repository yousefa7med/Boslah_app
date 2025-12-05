import 'package:depi_graduation_project/core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/tourApp_database.dart';

// @pragma('vm:entry-point')
// void alarmCallbackWithId(int scheduleId) async {
//   final prefs = await SharedPreferences.getInstance();
//
//   final placeName =
//       prefs.getString("schedule_place_name_$scheduleId") ?? "your place";
//   final note = prefs.getString("schedule_note_$scheduleId") ?? "";
//
//   NotificationService.showNotification(
//     id: scheduleId,
//     title: "Visit Reminder",
//     body: "It's time to visit $placeName. $note",
//   );
// }
@pragma('vm:entry-point')
void alarmCallbackWithId(int scheduleId) async {
  // Initialize your Floor database
  final db = await $FloortourDatabase.databaseBuilder('tourAppDB.db').build();
  final schedule = await db.scheduledao.selectScheduleById(scheduleId);

  final placeName = schedule?.name ?? "your place"; // use actual field
  final note = schedule?.note ?? "";

  NotificationService.showNotification(
    id: scheduleId,
    title: "Visit Reminder",
    body: "It's time to visit $placeName. $note",
  );
}
