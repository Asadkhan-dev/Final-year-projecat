import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box_users/utils/app_colors.dart';

Row header(context, String text, Icon icons) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colours.themeColor,
          size: 26,
        ),
      ),
      Text(
        text,
        style: TextStyle(
            fontSize: 20.sp,
            color: Colours.themeColor,
            fontWeight: FontWeight.w400),
      ),
      SizedBox(width: 6.w),
      icons,
    ],
  );
}
