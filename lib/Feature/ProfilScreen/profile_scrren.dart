import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_box_users/utils/app_colors.dart';
import 'package:medical_box_users/widgets/header_of_all_screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          header(
            context,
            'Profile',
             Icon(
              Icons.person,
              color: Colours.drawerColor,
              size: 22,
            ),
          ),


           Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.all(8.0.sp),
                  child: Container(

                    alignment: Alignment.center,
                    child:
                    CircleAvatar(
                      radius: 70.r,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration:  const BoxDecoration(shape: BoxShape.circle,
                          image:  DecorationImage(
                              image: AssetImage("assets/images/temp.png"),
                              fit: BoxFit.fill),
                        ),

                        ),

                      ),
                    ),


                  ),
                   ] ),
                SizedBox(width: 15.h,),
                Text('johan Smith',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child:
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          color: Colors.white38
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Email',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('johan@gmail.com',style: TextStyle(fontSize: 15.sp,color: Colors.grey)),
                                IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right,color: Colors.grey,size: 20.sp,), )
                              ],
                            )


                              ],
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child:
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          color: Colors.white38
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name ',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Jhon smith',style: TextStyle(fontSize: 15.sp,color: Colors.grey)),
                                IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right,color: Colors.grey,size: 20.sp,), )
                              ],
                            )


                              ],
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child:
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.r)),
                            color: Colors.white38
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('password ',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('********',style: TextStyle(fontSize: 15.sp,color: Colors.grey)),
                                IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right,color: Colors.grey,size: 20.sp,), )
                              ],
                            )


                          ],
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child:
                      Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15.r)),
                            color: Colors.white38
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Box ID ',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('1012119',style: TextStyle(fontSize: 15.sp,color: Colors.grey)),
                                IconButton(onPressed: (){}, icon: Icon(Icons.chevron_right,color: Colors.grey,size: 20.sp,), )
                              ],
                            )


                          ],
                        ),
                      ),

                    ),






                  ],
                ),

              ]),




    );
  }

}
