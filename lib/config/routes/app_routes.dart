import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/config/config.dart';
import 'package:todo/screens/create_task_screen.dart';
import 'package:todo/screens/home_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigatorKey,
    builder: HomeScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigatorKey,
    builder: CreateTaskScreen.builder,
  ),
];
