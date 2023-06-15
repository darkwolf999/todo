import 'package:logger/logger.dart';

class MyLogger {
  static final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      lineLength: 50,
      errorMethodCount: 3,
      colors: true,
      printEmojis: true,
    ),
  );

  static void emptyLog([
    dynamic message = 'triggered',
    Level level = Level.verbose,
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.log(level, message, error, stackTrace);
  }

  static void log(
    dynamic message, [
    Level level = Level.verbose,
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.log(level, message, error, stackTrace);
  }

  static void verboseLog(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.v(message, error, stackTrace);
  }

  static void debugLog(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.d(message, error, stackTrace);
  }

  static void infoLog(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.i(message, error, stackTrace);
  }

  static void warningLog(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.w(message, error, stackTrace);
  }

  static void errorLog(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.e(message, error, stackTrace);
  }

  static void wtfLog(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    logger.wtf(message, error, stackTrace);
  }
}
