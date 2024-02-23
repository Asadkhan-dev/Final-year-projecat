import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box_users/utils/app_colors.dart';
import 'package:medical_box_users/utils/app_sizebox.dart';
import 'package:medical_box_users/widgets/button_style.dart';
import 'package:medical_box_users/widgets/input_decoration.dart';

import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  String error = '';

  TextEditingController box_id = TextEditingController();
  TextEditingController admin_id = TextEditingController();
  TextEditingController team_leader_email = TextEditingController();
  TextEditingController contact_number = TextEditingController();
  TextEditingController team_id = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colours.whiteBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 114.h,
            ),
            Center(
              child: Image(
                image: const AssetImage("assets/images/firstaidIcon.png"),
                width: ScreenUtil().setWidth(180),
                height: ScreenUtil().setHeight(91),
              ),
            ),
            fixSizedBox40,
            Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    width: 290.w,
                    height: 50.h,
                    child: TextFormField(
                      controller: box_id,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Box ID"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: false,
                      controller: admin_id,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Admin ID"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: false,
                      controller: team_leader_email,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Team Leader Email"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: false,
                      controller: contact_number,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Contact Number"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      controller: team_id,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Team ID"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: true,
                      controller: password,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Password"),
                    ),
                  ),
                  fixSizedBox10,
                  SizedBox(
                    width: ScreenUtil().setWidth(290),
                    height: ScreenUtil().setHeight(50),
                    child: TextFormField(
                      obscureText: true,
                      controller: confirm_password,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                      decoration: inputDecoration("Confirm Password"),
                    ),
                  ),
                  fixSizedBox20,
                  ElevatedButton(
                    onPressed: () {
                      // context.read<AuthenticationService>().signUp(
                      //     email: box_id.text.trim(),
                      //     password: password.text.trim());
                      Navigator.pushNamed(context, 'login_screen');
                    },
                    style: buttonStyle,
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
