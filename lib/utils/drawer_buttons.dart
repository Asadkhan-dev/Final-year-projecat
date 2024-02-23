import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';
import 'app_sizebox.dart';
import 'dividers.dart';

class DrawerButtons extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const DrawerButtons({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  State<DrawerButtons> createState() => _DrawerButtonsState();
}

class _DrawerButtonsState extends State<DrawerButtons> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.text == "Home"){
          Navigator.pushNamed(context, 'home_screen');
        }
        else if(widget.text == "User"){
          Navigator.pushNamed(context, 'users_screen');
        }
        else if(widget.text == "Map"){
          Navigator.pushNamed(context, 'map_screen');
        }
        else if(widget.text == "Temperature"){
          Navigator.pushNamed(context, 'temperature_screen');
        }
        else if(widget.text == 'SignOut'){
          // context.read<AuthenticationService>().signOut();
          Navigator.pushReplacementNamed(context, 'login_screen');
        }
      },
      child: SizedBox(
        height: 82.h,
        width: 42.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colours.whiteBackgroundColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              fixSizedBox10,
              SizedBox(
                  width: 130.w, child: drawerDivider),
            ],
          ),
        ),
      ),
    );
  }
}
