import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fizmat_app_flutter/fizmat_utils/database_manager.dart';
import 'package:fizmat_app_flutter/fizmat_utils/user.dart';
import 'package:fizmat_app_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const HomePage();
    }
    return Scaffold(
      body: Center(
          child: TextButton(
        onPressed: register,
        child: const Text("Register"),
      )),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null || !googleUser.email.contains("@fizmat.kz")) {
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
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
