import 'package:cruze/screens/auth/forgot_pass_screen.dart';
import 'package:cruze/screens/auth/signup.dart';
import 'package:cruze/screens/join_waitlist.dart';
import 'package:cruze/services/api_service.dart';

// import 'package:cruze/services/auth_service.dart';

import 'package:cruze/utils/border_style.dart';
import 'package:cruze/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import 'package:provider/provider.dart';

import '../../utils/textstyles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Api>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: 189.h,
            left: 41.w,
            right: 51.w,
          ),
          child: Column(
            children: [
              SizedBox(
                width: 298.w,
                height: 129.h,
                child: Image.asset(
                  'assets/cruzeLogo.png',
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                width: 310.w,
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        style: textFieldStyle,
                        controller: emailController,
                        validator: ValidationBuilder()
                            .minLength(5)
                            .maxLength(50)
                            .build(),
                        decoration: InputDecoration(
                          hintText: 'enter email...',
                          hintStyle: hintTextStyle,
                          enabledBorder: borderStyle,
                          errorBorder: errorborderStyle,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        style: textFieldStyle,
                        controller: passwordController,
                        validator: ValidationBuilder(
                                requiredMessage:
                                    "Password should be greater of length  6")
                            .minLength(6)
                            .maxLength(50)
                            .build(),
                        decoration: InputDecoration(
                          hintText: 'enter password...',
                          hintStyle: hintTextStyle,
                          enabledBorder: borderStyle,
                          helperText: "Password should not be less than 6",
                          errorBorder: errorborderStyle,
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                //Send to JoinWaitList Page
                onTap: () async {
                  if (_form.currentState!.validate()) {
                    try {
                      var jwt = await authService.attemptLogin(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      if (jwt != 401) {
                        await Api.storage.write(key: 'jwt', value: jwt);

                        if (context.mounted) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => JoinWaitList(
                                  token: jwt,
                                ),
                              ));
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Email or Password is Incorrect",
                                style: textFieldStyle.copyWith(fontSize: 12.sp),
                              ),
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString(),
                            style: textFieldStyle.copyWith(fontSize: 12.sp),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  width: 185.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
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
                      builder: (context) => SignupWaitlist(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 224.w,
                  child: Text(
                    "don't have an account? create account",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: primaryColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 206.w,
                // height: 15.h,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: Text(
                    "forgot your password? request a change",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: primaryColor,
                      fontFamily: 'Poppins',
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
