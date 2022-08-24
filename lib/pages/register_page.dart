import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fizmat_app_flutter/fizmat_utils/database_manager.dart';
import 'package:fizmat_app_flutter/fizmat_utils/user.dart';
import 'package:fizmat_app_flutter/pages/discover_page.dart';
import 'package:fizmat_app_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../icons.dart';
import '../widgets/svg_asset.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return HomePage();
    }
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RacingLinesBehaviour(
          direction: LineDirection.Ttb,
          numLines: 15,
        ),
        child: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            //physics: const BouncingScrollPhysics(),
            physics: const ClampingScrollPhysics(),
            children: [
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 28.w,
                  right: 18.w,
                  top: 16.h,
                ),
                child: Text("Log into your @fizmat account to",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.w,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 28.w,
                  right: 18.w,
                  top: 16.h,
                ),
                child: AnimatedTextKit(
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Discover',
                        speed: Duration(milliseconds: 100),
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 48.w,
                            fontWeight: FontWeight.bold),
                      ),
                      TypewriterAnimatedText(
                        'Communicate',
                        speed: Duration(milliseconds: 100),
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 48.w,
                            fontWeight: FontWeight.bold),
                      ),
                      TypewriterAnimatedText(
                        'Vote',
                        speed: Duration(milliseconds: 100),
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 48.w,
                            fontWeight: FontWeight.bold),
                      ),
                      TypewriterAnimatedText(
                        'Share',
                        speed: Duration(milliseconds: 100),
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 48.w,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
              SizedBox(
                height: 320.h,
              ),
              Container(
                child: Center(
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () async {
                      DatabaseManager dat = DatabaseManager();
                      UserCredential? credential = await signInWithGoogle();
                      if (credential == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Используйте fizmat аккаунт"),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                        ));
                        return;
                      }
                      User? us = credential.user;
                      if (us == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Произошла ошибка"),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                        ));
                        return;
                      }
                      UserFiz user = UserFiz();
                      user.setEmail(us.email);
                      user.setName(us.displayName);
                      user.setPhotoURL(us.photoURL);
                      user.setUID(us.uid);
                      final fcmT = await FirebaseMessaging.instance.getToken();
                      user.setFcmToken(fcmT);
                      dat.addUser(user);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Успешно"),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                      ));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null || !googleUser.email.contains("@fizmat.kz")) {
      GoogleSignIn().signOut();
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void register() async {
    DatabaseManager dat = DatabaseManager();
    UserCredential? credential = await signInWithGoogle();
    if (credential == null) return;
    User? us = credential.user;
    if (us == null) return;
    UserFiz user = UserFiz();
    user.setEmail(us.email);
    user.setName(us.displayName);
    user.setPhotoURL(us.photoURL);
    final fcmT = await FirebaseMessaging.instance.getToken();
    user.setFcmToken(fcmT);
    dat.addUser(user);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void go_main() {
    //Get.to(()=> DiscoverPage());
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }
}
