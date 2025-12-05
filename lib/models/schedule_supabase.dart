import 'package:depi_graduation_project/models/schedule_model.dart';

class ScheduleSupabase extends ScheduleModel {
  final int? scheduleId; // Supabase BIGSERIAL

  ScheduleSupabase({
    this.scheduleId,
    required int placeId,
    required String date, // "2025-01-10"
    required String hour, // "14:30"
    required String? note,
    required bool isDone,
    required int createdAt,
    required String? userId,
    required double? lat,
    required double? lng,
    required String? image,
    required String? name,
  }) : super(
         placeId: placeId,
         date: date,
         hour: hour,
         name: name,
         note: note,
         isDone: isDone,
         createdAt: createdAt,
         userId: userId,
         lat: lat,
         lng: lng,
         image: image,
       );

  factory ScheduleSupabase.fromMap(Map<String, dynamic> map) {
    return ScheduleSupabase(
      scheduleId: map['schedule_id'] as int?,
      placeId: map['place_id'] as int,
      date: map['date'] as String,
      hour: map['hour'] as String,
      note: map['note'] as String?,
      isDone: map['is_done'] as bool? ?? false,
      createdAt: map['created_at'] as int,
      userId: map['user_id'] as String?,
      lat: map['lat'] as double?,
      lng: map['lng'] as double?,
      image: map['image'] as String?,
      name: map['name'] as String?,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'schedule_id': scheduleId,
  //     'place_id': placeId,
  //     'date': date,
  //     'hour': hour,
  //     'note': note,
  //     'is_done': isDone,
  //     'created_at': createdAt,
  //     'user_id': userId,
  //     'lat': lat,
  //     'lng': lng,
  //     'image': image,
  //     'name': name,
  //   };
  // }
  Map<String, dynamic> toMap() {
    final map = {
      'place_id': placeId,
      'date': date,
      'hour': hour,
      'note': note,
      'is_done': isDone,
      'created_at': createdAt,
      'user_id': userId,
      'lat': lat,
      'lng': lng,
      'name': name,
      'image': image,
    };

    // Include schedule_id only if it's not null (for updates)
    if (scheduleId != null) {
      map['schedule_id'] = scheduleId;
    }

    return map;
  }
}
