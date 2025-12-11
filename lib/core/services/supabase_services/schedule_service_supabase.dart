import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../main.dart';
import '../../../models/schedule_supabase.dart';
import '../../errors/app_exception.dart';
import '../../functions/parse_time.dart';
import '../notification_service.dart';

class ScheduleServiceSupabase {
  ScheduleServiceSupabase();

  Future<void> createSchedule(ScheduleSupabase schedule) async {
    try {
      await cloud
          .from('schedules')
          .insert(schedule.toMap())
          .select()
          .single();

      // final id = inserted['schedule_id'] as int;
      //!بص علي سطر 20
      NotificationService.scheduleNotification(
        id: schedule.notificationId!,
        title: "Visit Reminder",
        body: "You have a visit today!",
        date: DateTime.parse(schedule.date), // DateTime
        time: parseTime(schedule.hour), // TimeOfDay
      );
    } on PostgrestException catch (e) {
      throw AppException(msg: e.message);
    } catch (e) {
      throw AppException(msg: "Failed to schedule");
    }
  }

  /// Delete a schedule and cancel the alarm
  Future<void> deleteSchedule(int? scheduleId, int? notificationId) async {
    try {
      await cloud.from('schedules').delete().eq('schedule_id', scheduleId!);
      // Cancel the alarm
      await AwesomeNotifications().cancel(notificationId!);
    } on PostgrestException catch (e) {
      throw AppException(msg: e.message);
    } catch (e) {
      throw AppException(msg: "Failed to schedule");
    }
  }

  /// Mark a schedule as done
  Future<void> markAsDone(int scheduleId) async {
    await cloud
        .from('schedules')
        .update({'is_done': true})
        .eq('schedule_id', scheduleId);

    // Optionally, cancel the alarm if you don't want notifications anymore
  }

  /// Fetch all schedules for the current user
  Future<List<ScheduleSupabase>> getSchedules(String userId) async {
    try {
      print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      final data = await cloud
          .from('schedules')
          .select()
          .eq('user_id', userId)
          .order('date', ascending: true)
          .order('hour', ascending: true);
      print('reyu');
      return (data as List)
          .map((e) => ScheduleSupabase.fromMap(e as Map<String, dynamic>))
          .toList();
    } on PostgrestException catch (e) {
      throw AppException(msg: e.message);
    } catch (e) {
      throw AppException(msg: "Failed to schedule");
    }
  }

  /// Fetch a single schedule by ID
  Future<ScheduleSupabase> getScheduleById(int scheduleId) async {
    final data = await cloud
        .from('schedules')
        .select()
        .eq('schedule_id', scheduleId)
        .maybeSingle();

    // if (data == null);
    return ScheduleSupabase.fromMap(data!);
  }

  Future<int> getNotificationId(int scheduleId) async {
    final data = await cloud
        .from('schedules')
        .select('notification_id')
        .eq('schedule_id', scheduleId)
        .maybeSingle();

    return data?['notification_id'] as int;
  }

  Future<void> updateNote(String Note, int scheduleId) async {
    try {
      await cloud
          .from('schedules')
          .update({'note': Note})
          .eq('schedule_id', scheduleId)
          .select()
          .single();

      // final id = inserted['schedule_id'] as int;
    } on PostgrestException catch (e) {
      throw AppException(msg: e.message);
    } catch (e) {
      throw AppException(msg: "Failed to Edit the note");
    }
  }
}
