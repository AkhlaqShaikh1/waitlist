import 'package:cruze/models/user_model.dart';
import 'package:cruze/screens/apply_referral_page.dart';
import 'package:cruze/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import '../utils/textstyles.dart';

class RefferalPage extends StatefulWidget {
  const RefferalPage({super.key, this.user, this.token});

  final UserModel? user;
  final String? token;

  @override
  State<RefferalPage> createState() => _RefferalPageState();
}

class _RefferalPageState extends State<RefferalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 45.h, left: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile(user: widget.user, token: widget.token),
                        ),
                      );
                    },
                    child: widget.user?.profilePicture == null
                        ? Icon(
                            Icons.account_circle_rounded,
                            color: primaryColor,
                            size: 30.r,
                          )
                        : Image.network(
                            widget.user?.profilePicture as String,
                            height: 30.h,
                            width: 30.w,
                          ),
                  ),
                  SizedBox(width: 5.w),
                  SizedBox(
                    child: Text(
                      'Hi, ${widget.user?.firstName}',
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
                height: 25.h,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15.w),
                // width: 202.w,
                child: Text(
                  'invite your \nfriends to \njump the \nqueue',
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 45.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 25.w),
                alignment: Alignment.centerLeft,
                height: 18.h,
                child: Text(
                  'your referral code',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                width: 350.w,
                height: 60.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: primaryColor, width: 3.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Text(
                        '${widget.user!.ref}',
                        style: TextStyle(
                          color: cruzePinkColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150.w,
                    ),
                    IconButton(
                      alignment: Alignment.centerRight,
                      icon: const Icon(
                        Icons.copy,
                        color: primaryColor,
                      ),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(
                            text: '${widget.user!.ref}',
                          ),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Copied to Clipboard",
                                style: textFieldStyle.copyWith(fontSize: 12.sp),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w),
                // width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Perks:',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.w),
                width: 336.w,
                height: 120.h,
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text:
                        '1. jump the queue and get access to the application earlier than other. \n2. get a chance to be a part of the OGs club. \n3. get a chance to earn',
                    style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                    children: [
                      TextSpan(
                        text: ' "Cruze coins".',
                        style: TextStyle(
                          color: cruzePinkColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplyReferralPage(
                        user: widget.user,
                        token: widget.token,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 310.w,
                  height: 55.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 44.w, right: 44.w),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Apply referral',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
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
                      builder: (context) => Profile(
                        user: widget.user,
                        token: widget.token,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 310.w,
                  height: 55.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 44.w, right: 44.w),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'View friends who joined',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
