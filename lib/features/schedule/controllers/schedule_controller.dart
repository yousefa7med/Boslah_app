import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/database/models/schedules.dart';
import '../../../core/errors/app_exception.dart';
import '../../../main.dart';

class ScheduleController extends GetxController {
  final allSchedules = <Schedule>[].obs;
  final error = RxnString();
  final selectedCard = 1.obs;
  var today = DateTime.now().obs;

  final filteredSchedules = <Schedule>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    ever(today, (_) => update());

    Timer.periodic(const Duration(minutes: 1), (_) {
      today.value = DateTime.now();
      updateIsDoneForSchedules();
    });

    try {
      loadData();
    } on Exception catch (e) {
      error.value = e.toString();
    }

    super.onInit();
  }

  Future<void> loadData() async {
    try {
      final userId = cloud.auth.currentUser!.id;
      final localList = await database.scheduledao.selectSchedules(userId);

      localList.sort((a, b) {
        final dtA = combineDateAndTime(a.date, a.hour);
        final dtB = combineDateAndTime(b.date, b.hour);
        return dtA.compareTo(dtB);
      });

      allSchedules.value = localList;
      await updateIsDoneForSchedules();

      filteredSchedules.value = allSchedules;

    } catch (e) {
      throw AppException(msg: "Failed to load schedules");
    }
  }

  DateTime parseDate(String dateStr) {
    final parts = dateStr.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  String getStatus(String date) {
    final d = parseDate(date);
    final now = DateTime.now();

    if (d.year == now.year && d.month == now.month && d.day == now.day) {
      return "In Progress";
    }

    if (d.isBefore(DateTime(now.year, now.month, now.day))) {
      return "Completed";
    }

    return "Upcoming";
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.grey;
      case "In Progress":
        return Colors.green;
      case "Upcoming":
        return Colors.blueAccent;
      default:
        return Colors.black;
    }
  }



  Future<void> updateIsDoneForSchedules() async {
    for (var schedule in allSchedules) {
      final status = getStatus(schedule.date);

      final notDone = schedule.isDone == null || schedule.isDone == false;

      if (status == "Completed" && notDone) {
        if (kDebugMode) {
          print("Updating schedule: ${schedule.scheduleId}");
        }
        await database.scheduledao.markAsDone(schedule.scheduleId!);
        schedule.isDone = true;
      }
    }

    allSchedules.refresh();
  }

  void applyFilter(int filterIndex) {
    selectedCard.value = filterIndex;

    switch (filterIndex) {
      case 1:
        filteredSchedules.value = allSchedules;
        break;

      case 2:
        filteredSchedules.value = allSchedules.where((s) {
          final status = getStatus(s.date);
          return status == "Upcoming" || status == "In Progress";
        }).toList();
        break;

      case 3:
        filteredSchedules.value = allSchedules.where((s) {
          final status = getStatus(s.date);
          return status == "Completed";
        }).toList();
        break;
    }
  }

  DateTime combineDateAndTime(String dateStr, String hourStr) {
    final parts = dateStr.split('-');

    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    final hour = int.parse(hourStr.split(':')[0]);
    final minute = int.parse(hourStr.split(':')[1]);

    return DateTime(year, month, day, hour, minute);
  }


}
