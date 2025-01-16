// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyC41w3iysEJKRHwHrRa6Adw1zGj8nLmhpU',
    appId: '1:899155168948:web:7969db6b72f2c404ad51e1',
    messagingSenderId: '899155168948',
    projectId: 'recyclomator',
    authDomain: 'recyclomator.firebaseapp.com',
    storageBucket: 'recyclomator.firebasestorage.app',
    measurementId: 'G-L3T6M18E66',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAMIEIMANT36RoqZs-dLLCnhaD2Tg-POe4',
    appId: '1:899155168948:android:1bf51d55f6ec1ffead51e1',
    messagingSenderId: '899155168948',
    projectId: 'recyclomator',
    storageBucket: 'recyclomator.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNnHE6S1nn9CO7ojS_u8b586WEWJ3voqA',
    appId: '1:899155168948:ios:c534de50036d13a6ad51e1',
    messagingSenderId: '899155168948',
    projectId: 'recyclomator',
    storageBucket: 'recyclomator.firebasestorage.app',
    iosBundleId: 'com.example.recyclomator',
  );
}
