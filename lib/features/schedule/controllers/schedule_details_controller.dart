import 'package:Boslah/features/schedule/controllers/schedule_controller.dart';
import 'package:Boslah/main.dart';
import 'package:Boslah/models/schedule_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/supabase_services/schedule_service_supabase.dart';

class ScheduleDetailsController extends GetxController {
  late ScheduleModel scheduleplace;
  final editorIndicator = false.obs;

  final note = ''.obs;

  final noteCont = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    scheduleplace = Get.arguments as ScheduleModel;

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
    final notiID = await ScheduleServiceSupabase().getNotificationId(id);
    await ScheduleServiceSupabase().deleteSchedule(id, notiID);
    await database.scheduledao.deleteScheduleById(id);
  }

  Future<void> updateNote(int id, String newNote) async {
    final allSchedulers = Get.find<ScheduleController>();
    await ScheduleServiceSupabase().updateNote(newNote, id);
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
