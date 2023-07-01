import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/all_tasks/all_tasks.dart';
import 'package:todo/presentation/screens/task_detail/task_detail.dart';

class MyRouterDelegate extends RouterDelegate<List<RouteSettings>>
    with ChangeNotifier,
        PopNavigatorRouterDelegateMixin<List<RouteSettings>> {

  final _pages = <Page>[];

  @override
  final navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: List.of(_pages),
      onPopPage: _onPopPage,
    );
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;
  }

  @override
  Future<bool> popRoute() {
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      return Future.value(true);
    }
    //return _confirmAppExit();
    return Future.value(true);
  }


  MaterialPage _createPage(RouteSettings routeSettings) {
    Widget? child;
    switch (routeSettings.name) {
      case '/':
        child = AllTasksScreen();
        break;
      case '/task_detail':
        child = TaskDetailScreen();
        break;
      default:
        child = AllTasksScreen();
        break;
    }
    return MaterialPage(
      child: child,
      //key: UniqueKey(routeSettings.name ?? '/'),
      name: routeSettings.name,
      arguments: routeSettings.arguments,
    );
  }

  void pushPage({required String name, dynamic arguments}) {
    _pages.add(_createPage(
        RouteSettings(name: name, arguments: arguments)
    ));
    notifyListeners();
  }





  // Future<bool> _confirmAppExit() {
  //   return showDialog<bool>(
  //       context: navigatorKey.currentContext,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Exit App'),
  //           content: const Text('Are you sure you want to exit the
  //               app?'),
  //               actions: [
  //               TextButton(
  //               child: const Text('Cancel'),
  //           onPressed: () => Navigator.pop(context, true),
  //         ),
  //         TextButton(
  //         child: const Text('Confirm'),
  //         onPressed: () => Navigator.pop(context, false),
  //         ),
  //         ],
  //         );
  //       });
  // }









  // @override
  // // TODO: implement navigatorKey
  // GlobalKey<NavigatorState>? get navigatorKey => throw UnimplementedError();

  @override
  Future<void> setNewRoutePath(List<RouteSettings> configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }


}



