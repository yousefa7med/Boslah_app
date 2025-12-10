import 'package:flutter/material.dart';

TimeOfDay parseTime(String timeString) {
  // Expected format: "12:30 PM" or "7:05 AM"
  final parts = timeString.split(' ');
  final time = parts[0]; // "12:30"
  final period = parts[1].toUpperCase(); // "PM" or "AM"

  final timeParts = time.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  // Convert 12-hour format to 24-hour for TimeOfDay
  if (period == 'PM' && hour != 12) {
    hour += 12;
  } else if (period == 'AM' && hour == 12) {
    hour = 0;
  }

  return TimeOfDay(hour: hour, minute: minute);
}
