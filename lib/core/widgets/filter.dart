import 'package:Boslah/core/functions/is_dark.dart';
import 'package:Boslah/models/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../utilities/app_colors.dart';

class Filter extends StatefulWidget {
  const Filter({super.key, required this.filterList});
  final List<FilterModel> filterList;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(widget.filterList.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.filterList[index].onTap != null
                  ? widget.filterList[index].onTap!()
                  : null;
            },

            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: selectedIndex == index
                  ? AppColors.main
                  : (isDark() ? AppColors.darkSurface : Colors.grey.shade300),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    widget.filterList[index].icon != null
                        ? Row(
                            children: [
                              Icon(
                                widget.filterList[index].icon,
                                color: selectedIndex == index
                                    ? (Colors.white)
                                    : (isDark() ? Colors.white : Colors.black),
                              ),
                              const Gap(10),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Text(
                      widget.filterList[index].text,
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white
                            : (isDark() ? Colors.white : Colors.black),
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
