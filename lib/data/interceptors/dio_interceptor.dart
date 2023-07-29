import 'package:dio/dio.dart';

import 'package:todo/my_logger.dart';
import 'package:todo/env/env.dart';

class DioInterceptor extends InterceptorsWrapper {
  final Function(String, String) onErrorHandler;

  DioInterceptor(this.onErrorHandler);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 1-100% - вероятность получить ошибку с сервера
    //options.headers['X-Generate-Fails'] = 50;
    options.baseUrl = Env.baseUrl;
    options.headers['Authorization'] = 'Bearer ${Env.authToken}';
    MyLogger.log(
      'BASE_URL: ${options.baseUrl} \nAuthorization: ${options.headers['Authorization']}',
    );
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    MyLogger.log('DioException $err');

    onErrorHandler(
      err.response?.statusCode?.toString() ?? 'Unknown code',
      err.message ?? 'Unknown error',
    );
    //rethrow;
    return handler.next(err);
  }
}
