import 'dart:convert';
import 'dart:io';

import 'package:cruze/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'urls.dart';

class Api extends ChangeNotifier {
  final client = http.Client();
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  final userheader = {
    "Content-type": "application/json",
  };
  registerUser({
    required String username,
    required String password,
    required String confirmPassword,
    required int cnicNumber,
    required String firstname,
    required String lastname,
    required String dob,
    required String gender,
    required String email,
    required String phoneNum,
  }) async {
    var body = UserModel().toJson(
      username: username,
      password: password,
      confirmpassword: confirmPassword,
      cNIC: cnicNumber,
      dOB: dob,
      email: email,
      firstName: firstname,
      lastName: lastname,
      phonNum: phoneNum,
      gender: gender,
    );

    var response = await client.post(Uri.parse(baseUrl + registerUrl),
        body: jsonEncode(body), headers: userheader);
    Map<String, dynamic> error = jsonDecode(response.body);
    if (error.containsKey("DOB")) {
      throw error['DOB'][0];
    }
    if (error.containsKey('password')) {
      throw error['password'][0];
    }
    if (error.containsKey('email')) {
      throw error['email'][0];
    }
    if (error.containsKey('CNIC')) {
      throw error['CNIC'][0];
    }
    if (error.containsKey('phone_number')) {
      throw error['phone_number'][0];
    }
  }

  attemptLogin(String email, String password) async {
    var response = await client.post(Uri.parse(baseUrl + loginUrl),
        body: {"email": email, "password": password});

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      var jwt = body['access'];
      return jwt;
    }
    if (response.statusCode == 401) {
      return 401;
    }
    return null;
  }

  Future<UserModel> userDetails(token) async {
    var header = {
      "Content-type": "application/json",
      "Authorization": "JWT $token",
    };

    var response =
        await client.get(Uri.parse(baseUrl + meUrl), headers: header);
    var body = jsonDecode(response.body);
    UserModel user = UserModel.fromJson(body);
    return user;
  }

  updateProfilePicture(File imageFile, jwt , phoneNumber) async {
    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse(baseUrl + meUrl),
      );

      final multipartFile = await http.MultipartFile.fromPath(
        'profile_picture',
        imageFile.path,
      ); // Image is the parameter name

      request.files.add(multipartFile);

      request.headers['Authorization'] = "JWT $jwt";
      request.fields['phone_number'] = phoneNumber;
      final response = await request.send();
      if (response.statusCode == 200) {
        return ;
      } else {
       return ;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getWaitlistPosition(String? token) async {
    var header = {
      "Content-type": "application/json",
      "Authorization": "JWT $token",
    };

    var response =
        await client.get(Uri.parse(baseUrl + waitPositionUrl), headers: header);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body;
    }
    if(response.statusCode == 404){
          return "Error";
    }
  }

  sendReferral(token, referralCode) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "JWT $token",
    };
    var body = {
      "referral_code": "$referralCode",
    };
    var response = await client.post(Uri.parse(baseUrl + referralUrl),
        body: jsonEncode(body), headers: headers);
    var responseJson = jsonDecode(response.body) ;
    var res = responseJson as Map<String, dynamic>;

    if(res.containsKey('referral_code')){
      throw "Referral Field cant be blank";
    }
    return responseJson;
  }

  getReferrals(token) async{
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "JWT $token",
    };

    var response = await client.get(Uri.parse(baseUrl + referralUrl) , headers:  headers);

    var responseJson = jsonDecode(response.body);
    return responseJson;
  }

  getAllWaitlist(token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "JWT $token",
    };
    var response =
        await client.get(Uri.parse(baseUrl + allWaitlistPos), headers: headers);
    if (response.statusCode == 200) {
      var waitlist = jsonDecode(response.body);
      return waitlist;
    } else {
      return "error";
    }
  }

  resetPassword(email) async{
    var headers = {
      'Content-Type' : 'application/json'
    };
    var body = {
      'email' : email,
    };
    var response= await client.post(Uri.parse(baseUrl + passwordResetUrl), headers: headers , body: jsonEncode(body));
    if(response.statusCode == 200 || response.statusCode == 204){
      return "success";
    }
    else{
      return "Incorrect Email";
    }
  }

}
