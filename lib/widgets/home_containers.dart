import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box_users/utils/app_colors.dart';

Container homeContainer(String title, Icon subtitleIcon) {
  return Container(
    width: 345.w,
    height: 122.h,
    decoration: ShapeDecoration(
      color: Colours.listTileColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0.r),
        side: BorderSide(color: Colors.grey.shade300, width: 1.0.w),
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(11.w, 11.h, 11.w, 0.h),
              child: Text(
                title,
                style: TextStyle(
                    color: Colours.drawerColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(11.w, 11.h, 11.w, 0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subtitleIcon,
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 40,
                  color: Colours.drawerColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
