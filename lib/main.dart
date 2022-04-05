import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFFA9A9),
    ));

    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => GetMaterialApp(
        title: 'Momsound',
        theme: ThemeData(
          primaryColor: Color(0xFFFFA9A9),
          fontFamily: 'Noto_Sans_KR',
          backgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffffa9a9))),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffffa9a9)),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffffa9a9)),
            ),
          ),
        ),
        home: SplashScreen(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
