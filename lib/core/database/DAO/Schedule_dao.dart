

import 'package:depi_graduation_project/core/database/models/schedules.dart';
import 'package:floor/floor.dart';

@dao
abstract class ScheduleDao{
  @Query('SELECT * FROM schedules WHERE user_id = :uid ORDER BY scheduled_at ASC')
  Stream<List<Schedule>> selectSchedules(int uid);

  @Query('SELECT * FROM schedules WHERE schedule_id = :id')
  Future<Schedule?> selectScheduleById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertSchedule(Schedule schedule);

  @Query('UPDATE schedules SET isDone = 1 WHERE schedule_id = :id')
  Future<void> markAsDone(int id);

  @delete
  Future<int> deleteSchedule(Schedule schedule);

  @Query('DELETE FROM schedules WHERE user_id = :uid')
  Future<void> deleteAllSchedules(int uid);

}