import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box_users/utils/app_colors.dart';

final listView = ListView.builder(
  itemCount: 2, // replace with the length of your data list
  itemBuilder: (BuildContext context, int index) {
    return ListTile(
      contentPadding:
           EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
      tileColor: Colours.drawerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0.r),
        side: BorderSide(color: Colors.grey.shade300, width: 1.0.w),
      ),
      title: Text(
        'Item title',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0.sp,
        ),
      ),
      subtitle: Text(
        'Item subtitle',
        style: TextStyle(
          fontSize: 16.0.sp,
        ),
      ),
      dense: true,
      isThreeLine: true,
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        // add your onTap logic here
      },
    );
  },
);
