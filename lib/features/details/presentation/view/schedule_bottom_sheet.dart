import 'dart:ui';
import 'package:depi_graduation_project/core/database/models/schedules.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/utilities/app_colors.dart';
import '../../../../main.dart';
import '../../controllers/details_controller.dart';

class ScheduleBottomSheet extends StatefulWidget{
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final  noteController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dateController.dispose();
    timeController.dispose();
    noteController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),

        DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.40,
          maxChildSize: 0.80,
          builder: (_, scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  const Text(
                    "Schedule Visit",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Gap(20),

                  const Text("Date"),
                  const Gap(8),

                  TextField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2050),
                      );
                      if (picked != null) {
                        dateController.text =
                        "${picked.year}-${picked.month}-${picked.day}";
                      }
                    },
                    decoration: InputDecoration(

                      hintText: "Select a date",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.main, width: 2.8),
                      ),
                    ),
                  ),

                  const Gap(20),

                  const Text("Time"),
                  const Gap(8),

                  TextField(
                    controller: timeController,
                    readOnly: true,
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        timeController.text = picked.format(context);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Choose a time",
                      prefixIcon: const Icon(Icons.access_time),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.main, width: 2.8),
                      ),
                    ),
                  ),

                  const Gap(20),

                  const Text("Note (optional)"),
                  const Gap(8),

                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Leave a note...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.main, width: 2.8),
                      ),
                    ),
                  ),

                  const Gap(25),

                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 250,

                      child: ElevatedButton(onPressed: () async {
                        final cont = Get.find<DetailsController>();
                        if(dateController.text.isEmpty || timeController.text.isEmpty){
                          Get.snackbar('error', 'please fill Data and Hour');
                          return;
                        }
                        final sch = Schedule(
                          date: dateController.text,
                          image: cont.place.image ?? '',
                          hour: timeController.text,
                          note: noteController.text,
                          name: cont.place.name,
                          lat: cont.place.lat,
                          lng: cont.place.lng,
                          userId: cloud.auth.currentUser?.id ?? '',
                          placeId: cont.place.placeId,
                          isDone: false,
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                        );
                        await database.scheduledao.insertSchedule(sch);
                        dateController.clear();
                        timeController.clear();
                        noteController.clear();
                        debugPrint('schedule object: ${sch.date}');
                      },
                        style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: AppColors.main,
                            ), child: const Text('confirm',style: TextStyle(color: Colors.white),),
                      ),


                      // child: AppButton(
                      //   child: Text(
                      //     'Confirm',
                      //     style: AppTextStyle.regular18.copyWith(
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      //   onPressed: () async {
                      //     debugPrint('button pressed');
                      //
                      //   },
                      //
                      // ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
