import 'dart:io';
import 'package:cruze/models/user_model.dart';
import 'package:cruze/screens/auth/login.dart';
import 'package:cruze/screens/refferal_page.dart';
import 'package:cruze/services/api_service.dart';
import 'package:cruze/utils/colors.dart';
import 'package:cruze/utils/discover_widget.dart';
import 'package:cruze/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:editable_image/editable_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({this.token, this.user, super.key});

  final UserModel? user;
  final String? token;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final res = Api();

  @override
  void initState() {
    super.initState();
  }

  void _directUpdateImage(File? file) async {
    if (file == null) return;

    try {
      var re = await res.updateProfilePicture(
          file, widget.token, widget.user?.phoneNum);
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Profile Picture Cant Be uploaded, Please Try again Later",
            style: textFieldStyle.copyWith(fontSize: 12.sp),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var friends = res.getReferrals(widget.token);
    var waitlistPos = res.getWaitlistPosition(widget.token);
    var details = res.userDetails(widget.token);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(
          top: 20.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(right: 10.w),
                child: IconButton(
                  onPressed: () async {
                    await Api.storage.delete(key: "jwt");
                    if (context.mounted) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.logout_sharp,
                    color: cruzePinkColor,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              FutureBuilder(
                  future: details,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                          color: primaryColor);
                    }
                    var data = snapshot.data;
                    return EditableImage(
                      onChange: (file) => _directUpdateImage(file),
                      image: data?.profilePicture != null
                          ? Image.network(
                              data?.profilePicture as String,
                              fit: BoxFit.cover,
                            )
                          : widget.user!.gender == 'M'
                              ? Image.asset('assets/blue.png')
                              : Image.asset('assets/pink.png'),
                      size: 120.h,
                      editIconColor: Colors.black,
                      imageDefaultColor: primaryColor,
                      imageBorder: Border.all(color: primaryColor, width: 2.0),
                      editIconBorder:
                          Border.all(color: primaryColor, width: 2.0),
                      editIconBackgroundColor: primaryColor,
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  '${widget.user?.firstName} ${widget.user?.lastName}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 20.spMax,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              FutureBuilder(
                  future: waitlistPos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: primaryColor,
                      );
                    }
                    var data = snapshot.data;
                    return SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.8,
                      child: RichText(
                        text: TextSpan(
                          text: 'you are',
                          style: TextStyle(
                            fontSize: 12.spMax,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: ' no. ${data['rank']}',
                              style: TextStyle(
                                fontSize: 12.spMax,
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: ' on the ',
                              style: TextStyle(
                                fontSize: 12.spMax,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: 'waitlist',
                              style: TextStyle(
                                fontSize: 12.spMax,
                                color: cruzePinkColor,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '.',
                              style: TextStyle(
                                fontSize: 12.spMax,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: Icon(
                      Icons.language_sharp,
                      color: Colors.black,
                      size: 20.h,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: Icon(
                      Icons.directions_car_filled_outlined,
                      color: Colors.black,
                      size: 20.h,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor,
                    ),
                    child: Icon(
                      Icons.place_outlined,
                      color: Colors.black,
                      size: 20.h,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Container(
                width: 390.w,
                height: 495.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r)),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    stops: [0.2455, 0.389, 0.62, 1],
                    colors: [
                      Color(0xff56C6D0),
                      Color(0xff96AACE),
                      Color(0xffC098CC),
                      Color(0xffFD7DCA)
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 40.w, top: 14.h),
                          child: Text(
                            "the how’s & why’s",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 14.spMax,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Container(
                          padding: EdgeInsets.only(top: 14.h),
                          // decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                          alignment: Alignment.center,
                          child: Image.asset('assets/play_icon.png'),
                        ),
                      ],
                    ),
                    SizedBox(height: 11.h),
                    Container(
                      margin: EdgeInsets.only(left: 40.w),
                      child: Row(
                        children: [
                          const DiscoverWidget(
                              asset: 'assets/cruze_4.png', text: 'cruze?'),
                          SizedBox(width: 9.w),
                          const DiscoverWidget(
                              asset: 'assets/ham_list.png', text: 'waitlist?'),
                          SizedBox(width: 9.w),
                          const DiscoverWidget(
                              asset: 'assets/hour_glass.png', text: 'when?'),
                          SizedBox(width: 9.w),
                          const DiscoverWidget(
                              asset: 'assets/question.png', text: 'how?'),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Container(
                      margin: EdgeInsets.only(left: 40.w),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "your friends who joined..",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    SizedBox(
                      height: 160.h,
                      child: FutureBuilder(
                          future: friends,
                          builder: (ctx, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(
                                color: primaryColor,
                              );
                            }
                            var data = snapshot.data as List;

                            return data.isEmpty
                                ? Center(
                                    child: Text(
                                      "No Friends have joined yet",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 300.w,
                                        height: 160.h,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: data.length,
                                          itemBuilder: (context, index) => Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10.r,
                                                  ),
                                                  color: cruzePinkColor,
                                                ),
                                                child: Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                          10.r,
                                                        ),
                                                        topRight:
                                                            Radius.circular(
                                                          10.r,
                                                        ),
                                                      ),
                                                      child: data[index][
                                                                      'referred']
                                                                  [
                                                                  'profile_picture'] ==
                                                              null
                                                          ? data[index]['referred']
                                                                      [
                                                                      'gender'] ==
                                                                  'M'
                                                              ? Image.asset(
                                                                  'assets/blue.png',
                                                                  height: 120.h,
                                                                  width: 90.w,
                                                                  isAntiAlias:
                                                                      true,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : Image.asset(
                                                                  'assets/pink.png',
                                                                  height: 120.h,
                                                                  width: 90.w,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                          : Image.network(
                                                              '${data[index]['referred']['profile_picture']}',
                                                              height: 120.h,
                                                              width: 90.w,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Container(
                                                      color: cruzePinkColor,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 15.h,
                                                            child: Text(
                                                              "${data[index]['referred']['name']}",
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "#${data[index]['rank']}",
                                                              style: TextStyle(
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          }),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      margin: EdgeInsets.only(left: 40.w, right: 20.w),
                      child: Text(
                        "+ invite your friends and ask them to apply your referral to jump 5 positions up on the waitlist.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RefferalPage(
                              user: widget.user,
                              token: widget.token,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 135.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'invite friends',
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
