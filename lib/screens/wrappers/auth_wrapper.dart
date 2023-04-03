import 'package:cruze/screens/auth/login.dart';
import 'package:cruze/screens/join_waitlist.dart';
import 'package:cruze/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../services/api_service.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return FutureBuilder(
      future: secureStorage.read(key: "jwt"),
      builder: (context, snapshot)   {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var token = snapshot.data;

            if (token != null) {
              return FutureBuilder(
                  future: Api().userDetails(token),
                  builder:(context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.email != null) {
                          return JoinWaitList(token: token);
                        } else {

                          return const LoginPage();
                        }
                      } else {

                        return const LoginPage();
                      }
                    }

              );


            } else {
              return const LoginPage();
            }
          } else if (snapshot.hasError) {
            return const LoginPage();
          } else {
            return const LoginPage();
          }
        } else {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/cruze.png",
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                  const CircularProgressIndicator(
                    color: cruzePinkColor,
                  )
                ]),
          );
        }
      },
    );
  }
}
