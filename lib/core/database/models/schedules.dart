import 'package:floor/floor.dart';

@Entity(
  tableName: 'schedules',
)
class Schedule {
  @PrimaryKey(autoGenerate: true)
  final int? scheduleId;

  final int? placeId;

  final String date;
  final String hour;
  final String? note;
  final String? name;

  final bool? isDone;

  final int? createdAt;

  final String? userId;

  final double? lat;
  final double? lng;
  final String? image;


  Schedule({
    this.scheduleId,
    this.placeId,
    required this.date,
    this.note,
    this.isDone,
     this.createdAt,
    this.userId,
    this.name,
    this.lat,
    this.lng,
    required this.image,
    required this.hour,
  });
}
