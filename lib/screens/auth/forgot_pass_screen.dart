import 'package:cruze/screens/auth/login.dart';
import 'package:cruze/services/api_service.dart';
import 'package:cruze/utils/border_style.dart';
import 'package:cruze/utils/colors.dart';
import 'package:cruze/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final Api res = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2),
              child: Center(
                child: Image.asset(
                  'assets/cruzeLogo.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  cacheHeight:
                      (MediaQuery.of(context).size.height * 0.3).toInt(),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Form(
                key: _form,
                child: TextFormField(
                  controller: emailController,
                  style: textFieldStyle,
                  decoration: InputDecoration(
                    hintStyle: hintTextStyle,
                    hintText: "enter email..",
                    enabledBorder: borderStyle,
                    errorBorder: errorborderStyle,
                    errorStyle: textFieldStyle.copyWith(fontSize: 14.sp),
                  ),
                  validator: ValidationBuilder(requiredMessage: "Cant be empty")
                      .email()
                      .build(),
                ),
              ),
            ),
            SizedBox(height: 25.h),
            InkWell(
              onTap: () async {
                if (_form.currentState!.validate()) {
                  var rPass =
                      await res.resetPassword(emailController.text.trim());
                  if (context.mounted && rPass == 'success') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 3),
                      content: Text(
                        "Reset Link has been sent",
                        style: hintTextStyle.copyWith(
                            color: primaryColor, fontSize: 15.sp),
                      ),
                    ));
                    await Future.delayed(const Duration(seconds: 2));
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Send  Link",
                  style: textFieldStyle.copyWith(
                      color: Colors.black, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
