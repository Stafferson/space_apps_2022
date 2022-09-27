import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fizmat_app_flutter/pages/register_page.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'icons.dart';
import 'pages/home_page.dart';

late SharedPreferences? prefs;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: const ColorScheme.dark(
              onPrimary: Color(0xff121421),
              background: Color(0xff121421),
              primary: Color(0xff121421),
              surface: Color(0xff121421),
              onBackground: Color(0xff121421),
              onSurface: Color(0xff121421),
              error: Color(0xff121421),
              onError: Color(0xff121421),
              secondary: Color(0xff121421),
              onSecondary: Color(0xff121421),
            )
        ),
        home: AnimatedSplashScreen(
            duration: 100,
            splash: SvgAsset(
              assetName: AssetName.fizmatApp,
              width: 112.w,
            ),
            nextScreen: RegisterPage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Color(0xff121421)
        )
        //home: HomePage(),
      )
    );
  }
}
