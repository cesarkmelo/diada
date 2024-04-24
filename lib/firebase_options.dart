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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD3o7SZOflRkyY0DrkprBGyarGoDl3jf84',
    appId: '1:7547696335:web:a478cb2f657584122d73ba',
    messagingSenderId: '7547696335',
    projectId: 'proyectodiada-8f338',
    authDomain: 'proyectodiada-8f338.firebaseapp.com',
    storageBucket: 'proyectodiada-8f338.appspot.com',
    measurementId: 'G-ECEYDH5ZYJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQYgS6T1LjMhBOkXv2bxuSy8_fYb5xh70',
    appId: '1:7547696335:android:b48639de5a0dcee32d73ba',
    messagingSenderId: '7547696335',
    projectId: 'proyectodiada-8f338',
    storageBucket: 'proyectodiada-8f338.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD09n84DY0CzMKUoorU_dpG1VxCPZcdgXE',
    appId: '1:7547696335:ios:0fd75b2d84477f652d73ba',
    messagingSenderId: '7547696335',
    projectId: 'proyectodiada-8f338',
    storageBucket: 'proyectodiada-8f338.appspot.com',
    iosBundleId: 'com.alfamediaweb.proyectodiada.diada',
  );

}