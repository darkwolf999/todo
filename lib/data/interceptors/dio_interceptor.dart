import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo/my_logger.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.baseUrl = dotenv.env['BASE_URL'].toString();
    options.headers['Authorization'] = 'Bearer ${dotenv.env['AUTH_TOKEN'].toString()}';
    MyLogger.log(
      'BASE_URL: ${options.baseUrl} \nAuthorization: ${options.headers['Authorization']}',
    );
    return handler.next(options);
  }
}
