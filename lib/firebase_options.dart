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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyB4ifiSvMPglEAVEbHrL5_n3bvIuNH___Y',
    appId: '1:572859446495:web:1f7c686b9194f82648256a',
    messagingSenderId: '572859446495',
    projectId: 'ecommerce-6fed0',
    authDomain: 'ecommerce-6fed0.firebaseapp.com',
    storageBucket: 'ecommerce-6fed0.appspot.com',
    measurementId: 'G-VRR0EVLND0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBb9avU_pVLal9J6prMqyXC79a-ZC0ZEok',
    appId: '1:572859446495:android:0955f4b4b841722e48256a',
    messagingSenderId: '572859446495',
    projectId: 'ecommerce-6fed0',
    storageBucket: 'ecommerce-6fed0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSmLhii_WFREDgyeKjDTMUPcJWrxJa5eU',
    appId: '1:572859446495:ios:47b409f7ce9151fd48256a',
    messagingSenderId: '572859446495',
    projectId: 'ecommerce-6fed0',
    storageBucket: 'ecommerce-6fed0.appspot.com',
    androidClientId: '572859446495-65vkq7qmof3cqepfco78dnjtdnvkk4qh.apps.googleusercontent.com',
    iosClientId: '572859446495-d4i7po2qcdh2eekiu0ofutm2sgpal2u3.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecomm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCSmLhii_WFREDgyeKjDTMUPcJWrxJa5eU',
    appId: '1:572859446495:ios:47b409f7ce9151fd48256a',
    messagingSenderId: '572859446495',
    projectId: 'ecommerce-6fed0',
    storageBucket: 'ecommerce-6fed0.appspot.com',
    androidClientId: '572859446495-65vkq7qmof3cqepfco78dnjtdnvkk4qh.apps.googleusercontent.com',
    iosClientId: '572859446495-d4i7po2qcdh2eekiu0ofutm2sgpal2u3.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecomm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB4ifiSvMPglEAVEbHrL5_n3bvIuNH___Y',
    appId: '1:572859446495:web:c95bf3fb315cfcda48256a',
    messagingSenderId: '572859446495',
    projectId: 'ecommerce-6fed0',
    authDomain: 'ecommerce-6fed0.firebaseapp.com',
    storageBucket: 'ecommerce-6fed0.appspot.com',
    measurementId: 'G-92L96FW1FZ',
  );

}