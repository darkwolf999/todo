import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'package:todo/env/env.dart';

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

  static final FirebaseOptions web = FirebaseOptions(
    apiKey: Env.firebaseApiKeyWeb,
    appId: Env.firebaseAppIdWeb,
    messagingSenderId: Env.firebaseMessagingSenderIdWeb,
    projectId: Env.firebaseProjectIdWeb,
    authDomain: Env.firebaseAuthDomainWeb,
    storageBucket: Env.firebaseStorageBucketWeb,
    measurementId: Env.firebaseMeasurementIdWeb,
  );

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: Env.firebaseApiKeyAndroid,
    appId: Env.firebaseAppIdAndoird,
    messagingSenderId: Env.firebaseMessagingSenderIdAndroid,
    projectId: Env.firebaseProjectIdAndroid,
    storageBucket: Env.firebaseStorageBucketAndroid,
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: Env.firebaseApiKeyIos,
    appId: Env.firebaseAppIdIos,
    messagingSenderId: Env.firebaseMessagingSenderIdIos,
    projectId: Env.firebaseProjectIdIos,
    storageBucket: Env.firebaseStorageBucketIos,
    iosClientId: Env.firebaseIosClientIdIos,
    iosBundleId: Env.firebaseIosBundleIdIos,
  );
}
