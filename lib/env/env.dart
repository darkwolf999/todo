import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  //Yandex backend
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  static final String baseUrl = _Env.baseUrl;
  @EnviedField(varName: 'AUTH_TOKEN', obfuscate: true)
  static final String authToken = _Env.authToken;

  //Firebase options
  //web
  @EnviedField(varName: 'FIREBASE_API_KEY_WEB', obfuscate: true)
  static final String firebaseApiKeyWeb = _Env.firebaseApiKeyWeb;
  @EnviedField(varName: 'FIREBASE_APP_ID_WEB', obfuscate: true)
  static final String firebaseAppIdWeb = _Env.firebaseAppIdWeb;
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID_WEB', obfuscate: true)
  static final String firebaseMessagingSenderIdWeb =
      _Env.firebaseMessagingSenderIdWeb;
  @EnviedField(varName: 'FIREBASE_PROJECT_ID_WEB', obfuscate: true)
  static final String firebaseProjectIdWeb = _Env.firebaseProjectIdWeb;
  @EnviedField(varName: 'FIREBASE_AUTH_DOMAIN_WEB', obfuscate: true)
  static final String firebaseAuthDomainWeb = _Env.firebaseAuthDomainWeb;
  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET_WEB', obfuscate: true)
  static final String firebaseStorageBucketWeb = _Env.firebaseStorageBucketWeb;
  @EnviedField(varName: 'FIREBASE_MEASUREMENT_ID_WEB', obfuscate: true)
  static final String firebaseMeasurementIdWeb = _Env.firebaseMeasurementIdWeb;

  //android
  @EnviedField(varName: 'FIREBASE_API_KEY_ANDROID', obfuscate: true)
  static final String firebaseApiKeyAndroid = _Env.firebaseApiKeyAndroid;
  @EnviedField(varName: 'FIREBASE_APP_ID_ANDROID', obfuscate: true)
  static final String firebaseAppIdAndoird = _Env.firebaseAppIdAndoird;
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID_ANDROID', obfuscate: true)
  static final String firebaseMessagingSenderIdAndroid =
      _Env.firebaseMessagingSenderIdAndroid;
  @EnviedField(varName: 'FIREBASE_PROJECT_ID_ANDROID', obfuscate: true)
  static final String firebaseProjectIdAndroid = _Env.firebaseProjectIdAndroid;
  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET_ANDROID', obfuscate: true)
  static final String firebaseStorageBucketAndroid =
      _Env.firebaseStorageBucketAndroid;

  //ios
  @EnviedField(varName: 'FIREBASE_API_KEY_IOS', obfuscate: true)
  static final String firebaseApiKeyIos = _Env.firebaseApiKeyIos;
  @EnviedField(varName: 'FIREBASE_APP_ID_IOS', obfuscate: true)
  static final String firebaseAppIdIos = _Env.firebaseAppIdIos;
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID_IOS', obfuscate: true)
  static final String firebaseMessagingSenderIdIos =
      _Env.firebaseMessagingSenderIdIos;
  @EnviedField(varName: 'FIREBASE_PROJECT_ID_IOS', obfuscate: true)
  static final String firebaseProjectIdIos = _Env.firebaseProjectIdIos;
  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET_IOS', obfuscate: true)
  static final String firebaseStorageBucketIos = _Env.firebaseStorageBucketIos;
  @EnviedField(varName: 'FIREBASE_IOS_CLIENT_ID_IOS', obfuscate: true)
  static final String firebaseIosClientIdIos = _Env.firebaseIosClientIdIos;
  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID_IOS', obfuscate: true)
  static final String firebaseIosBundleIdIos = _Env.firebaseIosBundleIdIos;
}
