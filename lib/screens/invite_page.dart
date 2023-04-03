import 'package:cruze/screens/profile.dart';
import 'package:cruze/screens/refferal_page.dart';

import 'package:cruze/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/api_service.dart';
import '../utils/colors.dart';
import '../models/user_model.dart';

class InvitePage extends StatelessWidget {
  InvitePage({super.key, this.user, this.token});

  final UserModel? user;
  final String? token;
  final Api res = Api();

  @override
  Widget build(BuildContext context) {
    var position = res.getAllWaitlist(token);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: 55.h,
            left: 27.w,
          ),
          child: Column(
            children: [
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
                    child: user?.profilePicture == null ?
                    Icon(
                      Icons.account_circle_rounded,
                      color: primaryColor,
                      size: 30.r,
                    )
                        : Image.network(user?.profilePicture  as String , height: 30.h,width: 30.w,),
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
                height: 10.h,
              ),
              FutureBuilder(
                  future: position,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 2.r,
                      );
                    }
                    var data = snapshot.data as List;


                    return Column(
                      children: [
                        Container(
                          width: 185.w,
                          height: 100.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20.r),
                          child: Text(
                            '#${data.length}',
                            style: textFieldStyle.copyWith(fontSize: 40.sp),
                          ),
                        ),
                        Container(
                          width: 310.w,
                          height: 450.h,
                          margin: EdgeInsets.only(left: 20.w, right: 40.w),
                          child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length > 1 ? data.length : 1,
                              itemBuilder: (context, index) =>
                              data.isEmpty
                                  ? const Center(
                                child: Text("No one in waitlist"),
                              )
                                  : Center(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: 10.h,
                                  ),
                                  width: 310.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                    BorderRadius.circular(20.r),
                                    border: Border.all(
                                        color: data[index]['user']
                                        ['gender'] ==
                                            'M'
                                            ? primaryColor
                                            : cruzePinkColor,
                                        width: 2.w),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(
                                          left: 22.w,
                                          top: 16.h,
                                          bottom: 16.h,
                                        ),
                                        width: 47.w,
                                        height: 47.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: data[index]['user'][
                                            'profile_picture'] !=
                                                null
                                                ? NetworkImage(
                                                '${data[index]['user']['profile_picture']}')
                                                : data[index]['user']['gender'] ==
                                                'M'
                                                ? const AssetImage(
                                                'assets/blue.png')
                                                : const AssetImage(
                                                'assets/pink.png') as ImageProvider,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 18.w,
                                      ),
                                      SizedBox(
                                        width: 105.w,
                                        height: 24.h,
                                        child: Text(
                                          '${data[index]['user']['name']}',
                                          style: textFieldStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: data[index]['user']
                                            ['gender'] ==
                                                'M'
                                                ? primaryColor
                                                : cruzePinkColor,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 52.w,
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(right: 12.w),
                                        child: Text(
                                          '${data[index]['rank']}',
                                          style: textFieldStyle.copyWith(
                                            fontSize: 13,
                                            color: data[index]['user']
                                            ['gender'] ==
                                                'M'
                                                ? primaryColor
                                                : cruzePinkColor,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: 40.h,
              ),
              // SizedBox(height: 74.h),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RefferalPage(
                              user: user,
                              token: token,
                            ),
                      ));
                },
                child: Container(
                  width: 310.w,
                  height: 53.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 40.w, left: 20.w),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'jump the queue',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 20.spMax,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
