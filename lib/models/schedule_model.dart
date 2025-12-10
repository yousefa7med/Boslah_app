import 'package:floor/floor.dart';

class ScheduleModel {
  final int placeId;
    @PrimaryKey(autoGenerate: true)

  final int? scheduleId;

  final String date;
  final String hour;
  String note;
  final String? name;

  bool? isDone;

  final int? createdAt;

  final String? userId;

  final double? lat;
  final double? lng;
  final String? image;

  ScheduleModel({
    required this.placeId,
     this.scheduleId,
    required this.date,
   required this.note,
    this.isDone,
    this.createdAt,
    this.userId,
    required this.name,
    this.lat,
    this.lng,
    required this.image,
    required this.hour,
  });
}
