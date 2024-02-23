import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

InputDecoration inputDecoration(String hintText) {
  const double borderWidth = 1.0; // Set a fixed border width
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
      borderSide: BorderSide(
        width: 1.w,
        color: Colours.borderColor,
      ),
    ),

    errorBorder: OutlineInputBorder(
      //borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.w, // Set the border width
      ),
    ),
    enabledBorder:OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
      borderSide:const BorderSide(
        width: borderWidth, // Set the border width
        color: Colours.borderColor,
      ),
    ),
    focusColor: Colors.green,
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.w, 17.h, 50.w, 14.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      borderSide:const BorderSide(
        color: Colors.green,
        width: borderWidth, // Set the border width
      ),
    ),
  );
}
