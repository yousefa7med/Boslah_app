import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../main.dart';
import '../../../models/schedule_supabase.dart';
import '../../errors/app_exception.dart';
import '../alarm_callback.dart';
import 'package:intl/intl.dart';

class ScheduleServiceSupabase {
  ScheduleServiceSupabase();

  Future<void> createSchedule(ScheduleSupabase schedule) async {
    try {
      final inserted = await cloud
          .from('schedules')
          .insert(schedule.toMap())
          .select()
          .single();

      final id = inserted['schedule_id'] as int;

      // final scheduledDateTime = DateTime.parse(
      //   "${schedule.date} ${schedule.hour}:00",
      // );
      final dateString = "${schedule.date} ${schedule.hour}";
      // -> "2025-12-5 9:59 AM"

      // FIX: Correct formatter for 12-hour time
      final formatter = DateFormat("yyyy-M-d h:mm a");

      final scheduledDateTime = formatter.parse(dateString);
      await AndroidAlarmManager.oneShotAt(
        scheduledDateTime,
        id,
        alarmCallbackWithId,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true,
      );
    } on PostgrestException catch (e) {
      throw AppException(msg: e.message);
    } catch (e) {
      throw AppException(msg: "Failed to schedule");
    }
  }

  /// Delete a schedule and cancel the alarm
  Future<void> deleteSchedule(int? scheduleId) async {
    try {
      await cloud.from('schedules').delete().eq('schedule_id', scheduleId!);
      // Cancel the alarm
      await AndroidAlarmManager.cancel(scheduleId);
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
    await AndroidAlarmManager.cancel(scheduleId);
  }

  /// Fetch all schedules for the current user
  Future<List<ScheduleSupabase>> getSchedules(String userId) async {
    final data = await cloud
        .from('schedules')
        .select()
        .eq('user_id', userId)
        .order('scheduled_at', ascending: true);

    return (data as List)
        .map((e) => ScheduleSupabase.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  /// Fetch a single schedule by ID
  Future<ScheduleSupabase?> getScheduleById(int scheduleId) async {
    final data = await cloud
        .from('schedules')
        .select()
        .eq('schedule_id', scheduleId)
        .maybeSingle();

    if (data == null) return null;
    return ScheduleSupabase.fromMap(data as Map<String, dynamic>);
  }
}
