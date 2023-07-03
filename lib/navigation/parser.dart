import 'package:flutter/material.dart';
import 'package:todo/domain/models/task_model.dart';

import 'package:todo/navigation/paths.dart';
import 'package:uuid/uuid.dart';
import 'navigation_state_dto.dart';

class TasksRouteInformationParser
    extends RouteInformationParser<NavigationStateDTO> {
  @override
  Future<NavigationStateDTO> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    final uri = Uri.parse(routeInformation.location ?? '');
    if (uri.pathSegments.isEmpty) {
      return Future.value(NavigationStateDTO.allTasksPage());
    }
    switch (uri.pathSegments[0]) {
      case Paths.allTasksPage:
        return Future.value(NavigationStateDTO.allTasksPage());
      case Paths.task:
        return Future.value(
          NavigationStateDTO.task(null),
        );
      default:
        return Future.value(NavigationStateDTO.allTasksPage());
    }
  }
}
