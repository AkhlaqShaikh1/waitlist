
import 'package:cruze/screens/auth/signup_continued.dart';

import 'package:cruze/utils/border_style.dart';
import 'package:cruze/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '../../utils/textstyles.dart';

class SignupWaitlist extends StatelessWidget {
  SignupWaitlist({super.key});

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset(
                  'assets/cruzeLogo.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: _formWidget(),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (form.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpContinued(
                          username: usernameController.text,
                          firstname: firstnameController.text,
                          lastname: lastnameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 185.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/login',
                  );
                },
                child: SizedBox(
                  width: 224.w,
                  child:  Text(
                    "Already have an account? Login",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 16.sp,
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

  _formWidget() {
    return Form(
      key: form,
      child: Column(
        children: [
          TextFormField(
            style: textFieldStyle,
            controller: firstnameController,
            validator: ValidationBuilder().build(),
            decoration: InputDecoration(
              hintText: 'enter first name...',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
          ),
          TextFormField(
            style: textFieldStyle,
            controller: lastnameController,
            validator: ValidationBuilder().build(),
            decoration: InputDecoration(
              hintText: 'enter last name...',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: textFieldStyle,
            controller: emailController,
            validator: ValidationBuilder().build(),
            decoration: InputDecoration(
              hintText: 'enter email...',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: textFieldStyle,
            controller: usernameController,
            validator: ValidationBuilder().build(),
            decoration: InputDecoration(
              hintText: 'enter username...',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: textFieldStyle,
            controller: passwordController,
            validator: ValidationBuilder().minLength(8).build(),
            decoration: InputDecoration(
              hintText: 'enter password...',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
            obscureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            style: textFieldStyle,
            controller: confirmPasswordController,
            validator: (value) {
              if (passwordController.text != confirmPasswordController.text) {
                return "Password does not match";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'confirm password...',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
