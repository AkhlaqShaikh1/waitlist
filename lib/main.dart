import 'package:cruze/routes/routes.dart';

import 'package:cruze/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(390, 844),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Api(),
          ),
        ],
        child: MaterialApp(
          title: 'cruZe',
          theme: ThemeData(
            primaryColor: Colors.black,
            brightness: Brightness.dark,
            fontFamily: 'Poppins',
          ),
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(),
          debugShowCheckedModeBanner: false,
          routes: Routes().routes,
        ),
      ),
    );
  }
}
