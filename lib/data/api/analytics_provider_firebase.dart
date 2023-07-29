import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:todo/data/api/analytics_provider.dart';

//In Terminal
//enable debugMode: adb shell setprop debug.firebase.analytics.app com.darkwolf.todo
//disable debugMode: adb shell setprop debug.firebase.analytics.app .none.

class FirebaseAnalyticsProvider implements AnalyticsProvider {
  final FirebaseAnalytics _firebaseAnalytics;

  FirebaseAnalyticsProvider({
    required FirebaseAnalytics firebaseAnalytics,
  }) : _firebaseAnalytics = firebaseAnalytics;

  @override
  Future<void> logAppOpen() async {
    _firebaseAnalytics.logAppOpen();
  }

  @override
  Future<void> logScreenView([String? screenClass, String? screenName]) async {
    _firebaseAnalytics.logScreenView(
      screenClass: screenClass,
      screenName: screenName,
    );
  }

  @override
  Future<void> logEvent(String name, [Map<String, Object>? parameters]) async {
    _firebaseAnalytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
