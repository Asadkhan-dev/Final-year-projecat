import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_box_users/utils/app_colors.dart';
import 'package:medical_box_users/widgets/app_bar.dart';
import 'package:medical_box_users/widgets/drawer.dart';
import 'package:medical_box_users/widgets/header_of_all_screens.dart';
import 'package:medical_box_users/widgets/map_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  {
  String selectedOption = ' ';

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.997484888266584, 71.46691819101065),
    zoom: 14.4746,
  );

  static const CameraPosition _kCECOS = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(33.95631023099256, 71.43736221534408),
      zoom: 18.151926040649414);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: ScreenUtil().setWidth(163),
        child: drawer(context),
      ),
      appBar: appBar,
      body: Column(
        children: [
          header(
            context,
            'Map',
             Icon(
              Icons.location_on_outlined,
              color: Colours.drawerColor,
              size: 22,

            ),


          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Colors.blueGrey,
                  height: double.infinity,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Positioned(
                  left: 70.w,
                  bottom: 10.h,
                  child: Container(
                    width: 200.w,
                    height: 150.h,
                    padding: EdgeInsets.all(8.0.r),
                    decoration: ShapeDecoration(
                      color: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 5.h),
                      height: 80.h,
                      width: 250.w,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all( Radius.circular(5.r)),
                        //color: Colors.green,
                        // color: Color,
                        image: const DecorationImage(
                            image: AssetImage("assets/images/temp.png"),
                            fit: BoxFit.fill),
                      ),

                    ),

                  ),
                )
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('CECOS University'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kCECOS));
  }
}
