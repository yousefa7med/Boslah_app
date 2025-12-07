import 'package:depi_graduation_project/models/schedule_model.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'schedules',
  indices: [
    Index(value: ['placeId', 'date', 'hour'], unique: true),
  ],
)
class Schedule extends ScheduleModel {
  @PrimaryKey(autoGenerate: true)
  final int? scheduleId;

  Schedule({
    this.scheduleId,
    super.placeId,
    required super.date,
    required super.note,
    super.isDone,
    super.createdAt,
    super.userId,
    super.name,
    super.lat,
    super.lng,
    required super.image,
    required super.hour,
  });
}
