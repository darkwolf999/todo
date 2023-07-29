import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo/data/models/dto/task_response_dto.dart';
import 'package:todo/my_logger.dart';
import 'package:todo/data/models/dto/task_dto.dart';
import 'package:todo/data/models/dto/tasks_list_dto.dart';
import 'package:todo/data/interceptors/dio_interceptor.dart';
import 'constants/api_constants.dart';
import 'network_tasks_api.dart';

class NetworkTasksApiImpl implements NetworkTasksApi {
  final Function(String, String) onErrorHandler;
  final SharedPreferences _prefs;
  final Dio _dio;

  NetworkTasksApiImpl({
    required this.onErrorHandler,
    required SharedPreferences prefs,
    required Dio dio,
  })  : _prefs = prefs,
        _dio = dio
          ..options.connectTimeout = const Duration(
            seconds: ApiConstants.connectTimeout,
          )
          ..interceptors.addAll([
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
            ),
            DioInterceptor(onErrorHandler),
          ]);

  @override
  Future<TasksListDto> fetchTasks() async {
    final Response<dynamic> response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.listEndpoint,
    );

    final tasksListDto = TasksListDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    return tasksListDto;
  }

  @override
  Future<TaskResponseDto> addNewTask(TaskDto taskDto) async {
    final taskJson = {'element': taskDto.toJson()};

    final Response<dynamic> response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.listEndpoint,
      options: Options(
        headers: {
          'X-Last-Known-Revision': _prefs.getInt('revision'),
        },
      ),
      data: taskJson,
    );

    final tasksResponseDto = TaskResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    return tasksResponseDto;
  }

  @override
  Future<TaskResponseDto> editTask(TaskDto taskDto) async {
    final taskJson = {'element': taskDto.toJson()};

    final Response<dynamic> response = await _dio.put<Map<String, dynamic>>(
      '${ApiConstants.listEndpoint}${taskDto.id}',
      options: Options(
        headers: {
          'X-Last-Known-Revision': _prefs.getInt('revision'),
        },
      ),
      data: taskJson,
    );

    final tasksResponseDto = TaskResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    return tasksResponseDto;
  }

  @override
  Future<TaskResponseDto> deleteTask(String uuid) async {
    final Response<dynamic> response = await _dio.delete<Map<String, dynamic>>(
      '${ApiConstants.listEndpoint}$uuid',
      options: Options(
        headers: {
          'X-Last-Known-Revision': _prefs.getInt('revision'),
        },
      ),
    );

    final tasksResponseDto = TaskResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    return tasksResponseDto;
  }

  @override
  Future<TaskResponseDto> fetchSingleTask(String uuid) async {
    final Response<dynamic> response = await _dio.get<Map<String, dynamic>>(
      '${ApiConstants.listEndpoint}$uuid',
    );

    final tasksResponseDto = TaskResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    _prefs.setInt(
      ApiConstants.shPrefsRevisionKey,
      tasksResponseDto.revision,
    );
    MyLogger.log('revision = ${_prefs.getInt('revision')}');

    return tasksResponseDto;
  }

  @override
  Future<TasksListDto> refreshTasks(List<TaskDto> tasksDto) async {
    final tasksDtoJson = {'list': tasksDto};
    final revision = _prefs.getInt('revision');

    final Response<dynamic> response = await _dio.patch<Map<String, dynamic>>(
      ApiConstants.listEndpoint,
      options: Options(
        headers: {
          'X-Last-Known-Revision': revision,
        },
      ),
      data: tasksDtoJson,
    );

    final tasksListDto = TasksListDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    return tasksListDto;
  }
}
