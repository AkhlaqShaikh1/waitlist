import 'package:cruze/models/user_model.dart';
import 'package:cruze/screens/refferal_page.dart';

import 'package:cruze/screens/profile.dart';
import 'package:cruze/services/api_service.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../utils/colors.dart';
import 'invite_page.dart';

// ignore: must_be_immutable
class JoinWaitList extends StatelessWidget {
  JoinWaitList({super.key, this.token});

  final String? token;

  final res = Api();
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    var details = res.userDetails(token);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: 50.h,
            left: 27.w,
            right: 27.w,
          ),
          child: FutureBuilder(
            future: details,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              user = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Bar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Profile(user: user, token: token),
                            ),
                          );
                        },
                        child: user?.profilePicture == null
                            ? Icon(
                                Icons.account_circle_rounded,
                                color: primaryColor,
                                size: 30.r,
                              )
                            : Image.network(
                                user?.profilePicture as String,
                                height: 30.h,
                                width: 30.w,
                              ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        // width: 100,
                        child: Text(
                          'Hi, ${user?.firstName}',
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: "Poppins",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.only(right: 26.w),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/cruze.png', // lightning bolt
                              height: 28.h,
                              width: 21.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 67.h,
                  ),
                  SizedBox(
                    height: 400.h,
                    width: 300.w,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ModelViewer(
                        src: 'assets/zabardast.glb',
                        cameraOrbit: '10deg 130deg 85%',
                        autoRotate: true,
                        autoRotateDelay: 500,
                        ar: true,
                        arScale: ArScale.auto,),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InvitePage(user: user, token: token),
                        ),
                      );
                    },
                    child: Container(
                      width: 310.w,
                      height: 53.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        '+the waitlist',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 9.h,
                  ),
                  SizedBox(
                    width: 246.w,
                    // height: 45.h,
                    child: Text(
                      '+ get on the waitlist to get early access of the application, a chance to get into the "OGs Club" and many more perks.',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RefferalPage(
                            user: user,
                            token: token,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 310.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: primaryColor, width: 3.r),
                      ),
                      child: Text(
                        '+ refferal',
                        style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    width: 278.w,
                    // height: 30.h,
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            '+ invite your friends and not only jump up the waitlist but earn',
                        style: TextStyle(
                          color: primaryColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' "Cruze coins".',
                            style: TextStyle(
                              color: cruzePinkColor,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
