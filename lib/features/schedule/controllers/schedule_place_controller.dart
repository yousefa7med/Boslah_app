import 'package:depi_graduation_project/core/database/models/schedules.dart';
import 'package:depi_graduation_project/features/schedule/controllers/schedule_controller.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchedulePlaceController extends GetxController {
  late Schedule scheduleplace;
  final editorIndicator = false.obs;

  final note = ''.obs;

  final noteCont = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    scheduleplace = Get.arguments as Schedule;

    note.value = scheduleplace.note;

    noteCont.text = scheduleplace.note;
  }

  @override
  void onClose() {
    noteCont.dispose();
    super.onClose();
  }

  Future<void> deleteSchedule(int id) async {
    final allSchedulers = Get.find<ScheduleController>();

    allSchedulers.viewedSchedules.removeWhere((f) => f.scheduleId == id);

    await database.scheduledao.deleteScheduleById(id);
  }

  Future<void> updateNote(int id, String newNote) async {
    final allSchedulers = Get.find<ScheduleController>();

    await database.scheduledao.updateNote(newNote, id);

    final sched = allSchedulers.viewedSchedules.firstWhere(
      (f) => f.scheduleId == id,
    );
    sched.note = newNote;

    note.value = newNote;

    scheduleplace.note = newNote;

    allSchedulers.loadData();
  }
}
