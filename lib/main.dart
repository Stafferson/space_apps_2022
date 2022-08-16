import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fizmat_app_flutter/widgets/svg_asset.dart';
import 'firebase_options.dart';

import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'icons.dart';
import 'pages/home_page.dart';


void main() async{


  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  //CollectionReference lessons_time = FirebaseFirestore.instance.collection("common_settings");

  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.dark()),
        home: AnimatedSplashScreen(
            duration: 100,
            splash: SvgAsset(
              assetName: AssetName.fizmatApp,
              width: 112.w,
            ),
            nextScreen: HomePage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Color(0xff121421)
        )
        //home: HomePage(),
      )
    );
  }
}
