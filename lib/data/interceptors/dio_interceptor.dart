import 'package:dio/dio.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/data/api/constants/api_constants.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer ${ApiConstants.accessToken}';
    MyLogger.log(
      'НЕ СМОТРИ СЮДА!!! --->>> ${options.headers['Authorization']}',
    );
    return handler.next(options);
  }
}
