

import 'package:cruze/screens/profile.dart';
import 'package:cruze/services/api_service.dart';

import 'package:cruze/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/user_model.dart';
import '../utils/colors.dart';

class ApplyReferralPage extends StatelessWidget {
  ApplyReferralPage({Key? key, this.user, this.token}) : super(key: key);
  final UserModel? user;
  final String? token;
  final Api res = Api();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController referralController = TextEditingController();

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
                              Profile(user: user, token: token),
                        ),
                      );
                    },
                    child:
                    user?.profilePicture == null ?
                    Icon(
                      Icons.account_circle_rounded,
                      color: primaryColor,
                      size: 30.r,
                    )
                    : Image.network(user?.profilePicture  as String , height: 30.h,width: 30.w,),
                  ),
                  SizedBox(width: 5.w),
                  SizedBox(
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
                height: 25.h,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 15.w, right: 72.w),
                width: 280.w,
                // height: 300.h,
                child: Text(
                  'apply your\nfriend\'s referral\nto jump\nthe queue',
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
                  'enter referral code',
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50.h,
                      width: 280.w,
                      margin: EdgeInsets.only(left: 15.w, top: 2.h),
                      child: Form(
                        key: _form,
                        child: TextFormField(
                          controller: referralController,
                          cursorHeight: 25.h,
                          decoration: InputDecoration(
                          border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "Enter Referral Code",
                            hintStyle: hintTextStyle,
                          ),
                          style: TextStyle(
                            color: cruzePinkColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              InkWell(
                onTap: () async {
                  if (_form.currentState!.validate()) {
                    try {
                      var refResponse = await res.sendReferral(
                          token, referralController.text.trim());
                      // print(refResponse);
                      if (context.mounted && refResponse == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Referral Applied",
                              style: textFieldStyle.copyWith(fontSize: 12.sp),
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      String errorString;

                      if(e == 'Referral Field cant be blank'){
                        errorString = "Referral Field cant be blank";
                      }
                      else{
                        errorString = "Referral maybe Incorrect/Already Used";
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            errorString,
                            style: textFieldStyle.copyWith(fontSize: 12.sp),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  width: 170.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 107.w, right: 128.w),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'apply referral',
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
                    fontWeight: FontWeight.w500,
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
                height: 63.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
