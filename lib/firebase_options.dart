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
    apiKey: 'AIzaSyDUMqdiRAeixDXA04qOa4Veq4h8kBMfgLc',
    appId: '1:680642491416:web:a108aa95c50ee6f1807f6d',
    messagingSenderId: '680642491416',
    projectId: 'm2mapp-91014',
    authDomain: 'm2mapp-91014.firebaseapp.com',
    storageBucket: 'm2mapp-91014.appspot.com',
    measurementId: 'G-E9Q4SFLH42',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD26Xsfct8PgF5dhAO2svVb-Uyzri4yw24',
    appId: '1:680642491416:android:24931db1a59adda6807f6d',
    messagingSenderId: '680642491416',
    projectId: 'm2mapp-91014',
    storageBucket: 'm2mapp-91014.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6gjZ3TEy4wFTdq_a1wO9FKJ3IF_oXHyU',
    appId: '1:680642491416:ios:554be72f6089d136807f6d',
    messagingSenderId: '680642491416',
    projectId: 'm2mapp-91014',
    storageBucket: 'm2mapp-91014.appspot.com',
    iosClientId: '680642491416-si1vv15uh5k5jcurhlj2jevncmbumm0f.apps.googleusercontent.com',
    iosBundleId: 'com.example.m2m',
  );
}
