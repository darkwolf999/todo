import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo/my_logger.dart';

class DioInterceptor extends InterceptorsWrapper {
  final Function(String, String) onErrorHandler;

  DioInterceptor(this.onErrorHandler);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 1-100% - вероятность получить ошибку с сервера
    //options.headers['X-Generate-Fails'] = 50;
    options.baseUrl = dotenv.env['BASE_URL'].toString();
    options.headers['Authorization'] = 'Bearer ${dotenv.env['AUTH_TOKEN'].toString()}';
    MyLogger.log(
      'BASE_URL: ${options.baseUrl} \nAuthorization: ${options.headers['Authorization']}',
    );
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler)  {

    MyLogger.log('DioException $err');

    onErrorHandler(
      err.response?.statusCode?.toString() ?? 'Unknown code',
      err.message ?? 'Unknown error',
    );

    return handler.next(err);
  }

}
