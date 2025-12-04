

import 'package:depi_graduation_project/core/database/models/schedules.dart';
import 'package:floor/floor.dart';

@dao
abstract class ScheduleDao{
  @Query('SELECT * FROM schedules WHERE userId = :uid ORDER BY date ASC, hour ASC')
  Future<List<Schedule>> selectSchedules(String uid);

  @Query('SELECT * FROM schedules WHERE scheduleId = :id')
  Future<Schedule?> selectScheduleById(int id);
  
  @Query('SELECT * FROM schedules WHERE userId = :id')
  Future<List<Schedule?>> selectAllScheduleById(int id);


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertSchedule(Schedule schedule);

  @Query('UPDATE schedules SET isDone = 1 WHERE scheduleId = :id')
  Future<void> markAsDone(int id);

  @delete
  Future<int> deleteSchedule(Schedule schedule);

  @Query('DELETE FROM schedules WHERE userId = :uid')
  Future<void> deleteAllSchedules(String uid);

}