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
        return macos;
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
    apiKey: 'AIzaSyBn_az87jUVp1VOZzuGDOkwdGRhCd_IYMw',
    appId: '1:476060949860:web:556ff5566b9b2d8f3b2e71',
    messagingSenderId: '476060949860',
    projectId: 'harbor-laptop',
    authDomain: 'harbor-laptop.firebaseapp.com',
    storageBucket: 'harbor-laptop.appspot.com',
    measurementId: 'G-C39WSKD52B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA02XMp3mkX7PfUasmiorn45H2oMpfhpkc',
    appId: '1:476060949860:android:e08f9e835892ee893b2e71',
    messagingSenderId: '476060949860',
    projectId: 'harbor-laptop',
    storageBucket: 'harbor-laptop.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDm-b1nMmwr_wbfocLuyhnoaq5aw6XW0C0',
    appId: '1:476060949860:ios:6e06da17d51742cd3b2e71',
    messagingSenderId: '476060949860',
    projectId: 'harbor-laptop',
    storageBucket: 'harbor-laptop.appspot.com',
    iosBundleId: 'com.example.laptopHarborApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDm-b1nMmwr_wbfocLuyhnoaq5aw6XW0C0',
    appId: '1:476060949860:ios:576262f023831d123b2e71',
    messagingSenderId: '476060949860',
    projectId: 'harbor-laptop',
    storageBucket: 'harbor-laptop.appspot.com',
    iosBundleId: 'com.example.laptopHarborApp.RunnerTests',
  );
}