import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_sizebox.dart';
import '../utils/drawer_buttons.dart';


Drawer drawer(_context) {
  return Drawer(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight:  Radius.circular(60.r),
        bottomRight: Radius.circular(80.r),
      ),
    ),
    elevation: 1.sh,
    backgroundColor: Colours.drawerColor,
    child: SafeArea(
      child: ListView(
        children: [
          fixSizedBox30,
          SizedBox(
            height: 30.h,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(_context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          fixSizedBox10,
          SizedBox(
            width: 85.w,
            height: 46.h,
            child: Placeholder(
              child: Center(
                child: Text(
                  'LOGO',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          fixSizedBox40,
          DrawerButtons(
            text: 'Home',
            onPressed: () {
              Navigator.pop(_context);
            },
          ),
          DrawerButtons(
            text: 'User',
            onPressed: () {},
          ),
          DrawerButtons(
            text: 'Map',
            onPressed: () {},
          ),
          DrawerButtons(
            text: 'Temperature',
            onPressed: () {},
          ),
          DrawerButtons(
            text: 'SignOut',
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}
