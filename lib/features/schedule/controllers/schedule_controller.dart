import 'dart:async';

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
  @override
  void onInit() {
    // TODO: implement onInit
    // يحدث اليوم كل دقيقة
    ever(today, (_) => update());

    // Timer يشيّك كل دقيقة
    Timer.periodic(Duration(minutes: 1), (_) {
      today.value = DateTime.now();
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

      if (localList.isNotEmpty) {
        allSchedules.value = localList;
        return;
      }
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

}
