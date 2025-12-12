import 'package:Boslah/core/functions/is_dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onPressed,
   this.onChange});
  final TextEditingController controller;
  final void Function() onPressed;
  final void Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (a){
        onPressed();
      },
      onChanged: onChange,
      controller: controller,
      style: const TextStyle(color: AppColors.main),
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.search,
            color: AppColors.main.withAlpha(200),
            size: 27,
          ),
        ),
        hintText: 'Search for attractions...',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 17.sp),
        filled: true,
        fillColor: isDark() ? const Color(0xff2A2A2A) : AppColors.fillTextField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 2.8),
        ),
      ),
    );
  }
}
