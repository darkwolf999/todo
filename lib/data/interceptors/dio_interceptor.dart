import 'package:dio/dio.dart';
import '../../my_logger.dart';
import '../api/constants/api_constants.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
      options.headers['Authorization'] = 'Bearer ${ApiConstants.accessToken}';
      MyLogger.log(options.headers['Authorization']);
      return handler.next(options);
    }
}

// dio.interceptors.add(
//   InterceptorsWrapper(
//     onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
//       options.headers['Authorization'] = 'Bearer ${ApiConstants.accessToken}';
//       MyLogger.log(options.headers['Authorization']);
//       return handler.next(options);
//     },
//     // onResponse: (Response response, ResponseInterceptorHandler handler) {
//     //   // Do something with response data.
//     //   // If you want to reject the request with a error message,
//     //   // you can reject a `DioException` object using `handler.reject(dioError)`.
//     //   return handler.next(response);
//     // },
//     // onError: (DioException e, ErrorInterceptorHandler handler) {
//     //   // Do something with response error.
//     //   // If you want to resolve the request with some custom data,
//     //   // you can resolve a `Response` object using `handler.resolve(response)`.
//     //   return handler.next(e);
//     // },
//   ),
// );