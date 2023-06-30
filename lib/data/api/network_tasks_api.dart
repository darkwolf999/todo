import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo/data/dto/task_response_dto.dart';
import 'package:todo/constants.dart' as Constants;
import 'package:todo/my_logger.dart';
import 'package:todo/data/dto/task_dto.dart';
import 'package:todo/data/dto/tasks_list_dto.dart';
import 'constants/api_constants.dart';

class NetworkTasksApi {
  final Dio _dio;
  final SharedPreferences _prefs;

  NetworkTasksApi({
    required Dio dio,
    required SharedPreferences prefs,
  })  : _dio = dio,
        _prefs = prefs;

  Future<TasksListDto> fetchTasks() async {
    final Response<dynamic> response = await _dio.get<Map<String, dynamic>>(
      '${ApiConstants.baseUrl}${ApiConstants.listEndpoint}',
    );

    final tasksListDto = TasksListDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    _prefs.setInt(
      Constants.shPrefsRevisionKey,
      tasksListDto.revision,
    );

    MyLogger.log('revision = ${_prefs.getInt('revision')}');

    return tasksListDto;
  }

  Future<TaskResponseDto> addNewTask(TaskDto taskDto) async {
    final taskJson = {'element': taskDto.toJson()};

    final Response<dynamic> response = await _dio.post<Map<String, dynamic>>(
      '${ApiConstants.baseUrl}${ApiConstants.listEndpoint}',
      options: Options(
        headers: {
          'X-Last-Known-Revision': _prefs.getInt('revision'),
          //'Authorization': 'Bearer $_accessToken',
        },
      ),
      data: taskJson,
    );

    final tasksResponseDto = TaskResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    _prefs.setInt(
      Constants.shPrefsRevisionKey,
      tasksResponseDto.revision,
    );
    MyLogger.log('revision = ${_prefs.getInt('revision')}');

    return tasksResponseDto;
  }

  Future<TaskResponseDto> editTask(TaskDto taskDto) async {
    final taskJson = {'element': taskDto.toJson()};

    final Response<dynamic> response = await _dio.put<Map<String, dynamic>>(
      '${ApiConstants.baseUrl}${ApiConstants.listEndpoint}${taskDto.id}',
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

    _prefs.setInt(
      Constants.shPrefsRevisionKey,
      tasksResponseDto.revision,
    );
    MyLogger.log('revision = ${_prefs.getInt('revision')}');

    return tasksResponseDto;
  }

  @override
  Future<TaskResponseDto> deleteTask(String uuid) async {
    final Response<dynamic> response = await _dio.delete<Map<String, dynamic>>(
      '${ApiConstants.baseUrl}${ApiConstants.listEndpoint}$uuid',
      options: Options(
        headers: {
          'X-Last-Known-Revision': _prefs.getInt('revision'),
        },
      ),
    );

    final tasksResponseDto = TaskResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    _prefs.setInt(
      Constants.shPrefsRevisionKey,
      tasksResponseDto.revision,
    );
    MyLogger.log('revision = ${_prefs.getInt('revision')}');

    return tasksResponseDto;
  }

  Future<TaskResponseDto> fetchSingleTask(String uuid) async {
    final Response<dynamic> response = await _dio.get<Map<String, dynamic>>(
      '${ApiConstants.baseUrl}${ApiConstants.listEndpoint}$uuid',
    );

    final tasksResponseDto = TaskResponseDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    _prefs.setInt(
      Constants.shPrefsRevisionKey,
      tasksResponseDto.revision,
    );
    MyLogger.log('revision = ${_prefs.getInt('revision')}');

    return tasksResponseDto;
  }

  Future<TasksListDto> refreshTasks(List<TaskDto> tasksDto) async {
    final tasksDtoJson = {'list': tasksDto};

    final Response<dynamic> response = await _dio.patch<Map<String, dynamic>>(
      '${ApiConstants.baseUrl}${ApiConstants.listEndpoint}',
      options: Options(
        headers: {
          'X-Last-Known-Revision': _prefs.getInt('revision'),
        },
      ),
      data: tasksDtoJson,
    );

    final tasksListDto = TasksListDto.fromJson(
      response.data as Map<String, dynamic>,
    );

    _prefs.setInt(
      Constants.shPrefsRevisionKey,
      tasksListDto.revision,
    );
    MyLogger.log('revision = ${_prefs.getInt('revision')}');

    return tasksListDto;
  }
}
