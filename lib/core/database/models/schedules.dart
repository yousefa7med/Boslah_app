import 'package:depi_graduation_project/models/schedule_model.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'schedules',
  indices: [
    Index(value: ['placeId', 'date', 'hour'], unique: true),
  ],
)
class Schedule extends ScheduleModel {
  Schedule({
    super.scheduleId,
    required super.placeId,
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

  @override
  set note(String note) {}
}
