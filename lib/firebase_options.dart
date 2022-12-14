// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOrQQwq1ELE_o_cxlcObvW6gwg7hgyCD4',
    appId: '1:311414511724:android:e838ff32a17c52aceb2049',
    messagingSenderId: '311414511724',
    projectId: 'testtest1-326506',
    databaseURL: 'https://testtest1-326506-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'testtest1-326506.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdeN46Q3qdVR9-UFX8CwhLFvHLvXbHa1o',
    appId: '1:311414511724:ios:fd0e610a299b8b67eb2049',
    messagingSenderId: '311414511724',
    projectId: 'testtest1-326506',
    databaseURL: 'https://testtest1-326506-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'testtest1-326506.appspot.com',
    androidClientId: '311414511724-0ai87cdvpa6samrqam4ka9d9ea436i2c.apps.googleusercontent.com',
    iosClientId: '311414511724-3g7na094jrcvsbsi8l2t71rphgi6a145.apps.googleusercontent.com',
    iosBundleId: 'com.example.fizmatAppFlutter',
  );
}
