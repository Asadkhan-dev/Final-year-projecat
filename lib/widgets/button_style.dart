import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colours.themeColor),
  elevation: MaterialStateProperty.all<double>(1.0.sh),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0.r),
      side: const BorderSide(color: Colours.borderColor),
    ),
  ),
);

ButtonStyle outlinedButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all(
    EdgeInsets.symmetric(vertical: 10.h, horizontal: 37.w),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
  elevation: MaterialStateProperty.all<double>(1.0.sh),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0.r),
      side: const BorderSide(color: Colours.borderColor),
    ),
  ),
);
