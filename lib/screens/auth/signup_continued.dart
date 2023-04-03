import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../../services/api_service.dart';
import '../../utils/border_style.dart';
import '../../utils/colors.dart';
import '../../utils/textstyles.dart';
import 'login.dart';

class SignUpContinued extends StatefulWidget {
  const SignUpContinued({
    Key? key,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  }) : super(key: key);
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  @override
  State<SignUpContinued> createState() => _SignUpContinuedState();
}

class _SignUpContinuedState extends State<SignUpContinued> {
  final TextEditingController dobController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController cnicController = TextEditingController();
  String gender = "Male";

  String dropdownvalue = 'Male';
  var items = [
    'Female',
    'Male',
    'Other',
  ];
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Api>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
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
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
              child: formWidget(),
            ),
            InkWell(
              onTap: () async {
                if (form.currentState!.validate()) {
                  try {
                    await authService.registerUser(
                        username: widget.username.trim(),
                        password: widget.password,
                        confirmPassword: widget.password,
                        cnicNumber: int.parse(cnicController.text),
                        firstname: widget.firstname,
                        lastname: widget.lastname,
                        dob: dobController.text,
                        gender: gender,
                        email: widget.email,
                        phoneNum: phoneController.text);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 2),
                          content: Text(
                            "Sign up Successful",
                            style: textFieldStyle.copyWith(fontSize: 12),
                          ),
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (r) => false);
                    }
                  } catch (e) {
                    if (e == '2') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString(),
                            style: textFieldStyle.copyWith(fontSize: 12),
                          ),
                        ),
                      );
                    }
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
                child:  Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Form formWidget() {
    return Form(
      key: form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            style: textFieldStyle,
            controller: cnicController,
            validator: ValidationBuilder().minLength(13).maxLength(13).build(),
            decoration: InputDecoration(
              hintText: 'enter cnic number...',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: textFieldStyle,
            controller: phoneController,
            validator: ValidationBuilder().minLength(11).maxLength(11).build(),
            decoration: InputDecoration(
              hintText: 'phone number...',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            style: textFieldStyle,
            controller: dobController,
            validator: ValidationBuilder().build(),
            decoration: InputDecoration(
              hintText: 'YYYY-MM-DD',
              hintStyle: hintTextStyle,
              enabledBorder: borderStyle,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButton(
            underline: Container(height: 2, color: primaryColor),
            dropdownColor: Colors.black,
            value: dropdownvalue,
            isExpanded: true,
            style: hintTextStyle,
            hint: Text(
              'Gender...',
              style: hintTextStyle,
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: secondaryColor,
            ),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
                gender = newValue;
                if (gender == "Male") {
                  gender = "M";
                }
                if (gender == "Female") {
                  gender = "F";
                }
                if (gender == "Other") {
                  gender = "O";
                }
              });
            },
          ),
        ],
      ),
    );
  }
}



                         
//                       // ignore: use_build_context_synchronously
                      