import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({Key? key, required this.asset, required this.text}) : super(key: key);
  final String asset;
  final String text;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 68.w,
          height: 68.w,
          decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle),
          child: Image.asset(asset),
        ),
        SizedBox(height: 4.h),
        Text(
          text,
          style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'),
        )
      ],
    );
  }
}
