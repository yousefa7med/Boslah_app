import 'package:floor/floor.dart';

@Entity(
  tableName: 'schedules',
)
class Schedule {
  @PrimaryKey(autoGenerate: true)
  final int? schedule_id;

  final String? place_id;

  final String scheduled_at;
  final String? note;

  final bool? isDone;

  final int created_at;

  final int? user_id;

  Schedule({
    this.schedule_id,
    this.place_id,
    required this.scheduled_at,
    this.note,
    this.isDone,
    required this.created_at,
    this.user_id
  });
}
