import 'dart:developer';

import 'package:Boslah/core/database/models/schedules.dart';
import 'package:Boslah/core/functions/has_internet.dart';
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


  final isLoading=true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
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
          viewedSchedules.value = allSchedules;
        },
      ),
      FilterModel(
        text: 'In Progress',
        icon: Icons.today,
        onTap: () {
          final todayStr =
              "${today.value.year.toString().padLeft(4, '0')}-"
              "${today.value.month.toString().padLeft(2, '0')}-"
              "${today.value.day.toString().padLeft(2, '0')}";
          viewedSchedules.value = allSchedules.where((p) {
            return p.date == todayStr;
          }).toList();
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
          final todayStr =
              "${today.value.year.toString().padLeft(4, '0')}-"
              "${today.value.month.toString().padLeft(2, '0')}-"
              "${today.value.day.toString().padLeft(2, '0')}";
          viewedSchedules.value = allSchedules.where((p) {
            return p.date != todayStr;
          }).toList();
        },
      ),
      FilterModel(
        text: 'Completed',
        icon: Icons.done_all,
        onTap: () {
          viewedSchedules.value =
              allSchedules.where((p) => p.isDone == true).toList();
        },
      ),
    ]);

    Timer.periodic(const Duration(minutes: 1), (_) {
      today.value = DateTime.now();
      updateIsDoneForSchedules();
    });
  }

  Future<void> loadData() async {
    try {
      isLoading.value=true;
      final userId = cloud.auth.currentUser!.id;

      // localList.sort((a, b) {
      //   final dtA = combineDateAndTime(a.date, a.hour);
      //   final dtB = combineDateAndTime(b.date, b.hour);
      //   log('uuuuuuuuuuuuuuuuuuuuuuuuuuuuu');
      //   return dtA.compareTo(dtB);
      // });
      final hasInt = await hasInternet();
      if (hasInt) {
        final remote = await ScheduleServiceSupabase().getSchedules(userId);
        allSchedules.value = remote;
        viewedSchedules.value = remote;
        await database.scheduledao.deleteAllSchedules(userId);
        for (var value in remote) {
          print('11111111111');
          try {
            await database.scheduledao.insertSchedule(
              Schedule(
                placeId: value.placeId,
                date: value.date,
                note: value.note,
                image: value.image,
                hour: value.hour,
                isDone: value.isDone,
                userId: value.userId,
                name: value.name,
                lat: value.lat,
                lng: value.lng,
              ),
            );
          } catch (_) {}
        }
      } else {
        final localList = await database.scheduledao.selectSchedules(userId);
        allSchedules.value = localList;
        viewedSchedules.value = localList;
      }

      log('doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    } catch (e) {
      throw AppException(msg: "Failed to load schedules");
    }finally{
      await Future.delayed(const Duration(milliseconds: 700));
      isLoading.value=false;
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
    for (var schedule in viewedSchedules) {
      final status = getStatus(schedule.date);

      final notDone = schedule.isDone == null || schedule.isDone == false;

      if (status == "Completed" && notDone) {
        if (kDebugMode) {
          print("Updating schedule: ${schedule.scheduleId}");
        }
        await database.scheduledao.markAsDone(schedule.scheduleId!);
        schedule.isDone = true;
        ScheduleServiceSupabase().markAsDone(schedule.scheduleId!);
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
