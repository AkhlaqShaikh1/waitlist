



import 'package:cruze/screens/auth/forgot_pass_screen.dart';
import 'package:cruze/screens/auth/login.dart';
import 'package:cruze/screens/auth/signup.dart';

import 'package:cruze/screens/join_waitlist.dart';
import 'package:cruze/screens/refferal_page.dart';
import 'package:cruze/screens/splashpage.dart';
import 'package:cruze/screens/wrappers/auth_wrapper.dart';

import '../screens/invite_page.dart';

class Routes{
  final  routes = {
    '/' : (context) => const SplashPage(),
    '/joinWait' : (context) => JoinWaitList(),
    '/login' : (context) => const LoginPage(),
    '/signup' : (context) => SignupWaitlist(),
    '/invite' : (context) =>  InvitePage(),
    '/refferal' : (context) => const RefferalPage(),

    '/splash' : (context) => const SplashPage(),
    '/wrapper' : (context) => const AuthWrapper(),
    '/forgotPass' : (context) =>  ForgotPasswordPage(),
  };
}
