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
    apiKey: 'AIzaSyCNYXKucIsLqf8UEfuJJs0DaUPRlBSbMBk',
    appId: '1:547347666262:web:ad238fb39334a7807832f7',
    messagingSenderId: '547347666262',
    projectId: 'pokedex-flutter-c0a00',
    authDomain: 'pokedex-flutter-c0a00.firebaseapp.com',
    databaseURL: 'https://pokedex-flutter-c0a00-default-rtdb.firebaseio.com',
    storageBucket: 'pokedex-flutter-c0a00.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC24gK3Ezvu6FIP2t4P08kvGGaU3sessrw',
    appId: '1:547347666262:android:5677ecee7ede08e67832f7',
    messagingSenderId: '547347666262',
    projectId: 'pokedex-flutter-c0a00',
    databaseURL: 'https://pokedex-flutter-c0a00-default-rtdb.firebaseio.com',
    storageBucket: 'pokedex-flutter-c0a00.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBW24OcJ4LPk5FLsXli5pfAdoevfEhlXb0',
    appId: '1:547347666262:ios:2175875ae55b9cdd7832f7',
    messagingSenderId: '547347666262',
    projectId: 'pokedex-flutter-c0a00',
    databaseURL: 'https://pokedex-flutter-c0a00-default-rtdb.firebaseio.com',
    storageBucket: 'pokedex-flutter-c0a00.appspot.com',
    iosBundleId: 'com.example.pokedexFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBW24OcJ4LPk5FLsXli5pfAdoevfEhlXb0',
    appId: '1:547347666262:ios:720d8129b00295577832f7',
    messagingSenderId: '547347666262',
    projectId: 'pokedex-flutter-c0a00',
    databaseURL: 'https://pokedex-flutter-c0a00-default-rtdb.firebaseio.com',
    storageBucket: 'pokedex-flutter-c0a00.appspot.com',
    iosBundleId: 'com.example.pokedexFlutter.RunnerTests',
  );
}
