import 'dart:developer';

import 'package:Boslah/core/services/supabase_services/schedule_service_supabase.dart';
import 'package:Boslah/models/schedule_model.dart';
import 'package:Boslah/models/filter_model.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/errors/app_exception.dart';
import '../../../main.dart';

class ScheduleController extends GetxController {
  final viewedSchedules = <ScheduleModel>[].obs;
  final allSchedules = <ScheduleModel>[].obs;

  final error = RxnString();
  final List<FilterModel> filterList = [];
  var today = DateTime.now().obs;

  @override
  Future<void> onInit() async {
    print('initttttt');
    try {
      await loadData();
    } catch (e) {
      error.value = e.toString();
    }
    ever(today, (_) => update());
    filterList.addAll([
      FilterModel(
        text: 'All',
        onTap: () {
          viewedSchedules.clear();
          viewedSchedules.addAll(allSchedules);
        },
      ),
      FilterModel(
        text: 'Upcoming',
        icon: Icons.pending_outlined,
        onTap: () {
          viewedSchedules.clear();
          for (var s in allSchedules) {
            print('Schedule date raw: "${s.date}"');
          }
          viewedSchedules.addAll(
            allSchedules.where((s) {
              final status = getStatus(s.date);
              return status == "Upcoming" || status == "In Progress";
            }).toList(),
          );
        },
      ),
      FilterModel(
        text: 'Completed',
        icon: Icons.done_all,
        onTap: () {
          viewedSchedules.clear();
          viewedSchedules.addAll(
            allSchedules.where((s) {
              final status = getStatus(s.date);
              return status == "Completed";
            }).toList(),
          );
        },
      ),
    ]);

    Timer.periodic(const Duration(minutes: 1), (_) {
      today.value = DateTime.now();
      updateIsDoneForSchedules();
    });

    // try {
    //   loadData();
    // } on Exception catch (e) {
    //   error.value = e.toString();
    // }
    try {
      await loadData();
    } catch (e) {
      error.value = e.toString();
    }
    super.onInit();
  }

  Future<void> loadData() async {
    try {
      final userId = cloud.auth.currentUser!.id;
      final localList = await database.scheduledao.selectSchedules(userId);

      // localList.sort((a, b) {
      //   final dtA = combineDateAndTime(a.date, a.hour);
      //   final dtB = combineDateAndTime(b.date, b.hour);
      //   log('uuuuuuuuuuuuuuuuuuuuuuuuuuuuu');
      //   return dtA.compareTo(dtB);
      // });
      if (localList.isNotEmpty) {
        allSchedules.value = localList;
        viewedSchedules.value = localList;
        await updateIsDoneForSchedules();

        return;
      } else {
        final remote = await ScheduleServiceSupabase().getSchedules(userId);
        allSchedules.value = remote;
        viewedSchedules.value = remote;
      }

      log('doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
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
  // DateTime parseDate(String dateStr) {
  //   return DateTime.parse(dateStr.split(" ").first);
  // }
  // DateTime parseDate(String dateStr) {
  //   try {
  //     return DateTime.parse(dateStr);
  //   } catch (_) {
  //     return DateTime.parse(dateStr.split(" ").first);
  //   }
  // }
  // DateTime parseDate(String dateStr) {
  //   try {
  //     // Try parsing full date/time string directly
  //     return DateTime.parse(dateStr);
  //   } catch (_) {
  //     // If fails, try parsing only the date part (before space)
  //     return DateTime.parse(dateStr.split(" ").first);
  //   }
  // }
  // DateTime parseDate(String dateStr) {
  //   try {
  //     return DateTime.parse(dateStr);
  //   } catch (e) {
  //     try {
  //       final dateOnly = dateStr.split(" ").first;
  //       return DateTime.parse(dateOnly);
  //     } catch (e2) {
  //       print("Failed to parse dateStr: $dateStr");
  //       rethrow;
  //     }
  //   }
  // }

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
    for (var schedule in viewedSchedules) {
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

    viewedSchedules.refresh();
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
