abstract class AnalyticsProvider {
  Future<void> logEvent(String name, [Map<String, Object>? parameters]);

  Future<void> logAppOpen();

  Future<void> logScreenView([String? screenClass, String? screenName]);
}
