import 'package:flutter/material.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/counter/counter_provider.dart';
import 'package:nft/pages/course_detail/course_detail_page.dart';
import 'package:nft/pages/course_list/course_list_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/login/login_page.dart';
import 'package:provider/provider.dart';

class AppRoute {
  factory AppRoute() => _instance;

  AppRoute._private();

  ///#region ROUTE NAMES
  /// -----------------
  static const String routeRoot = '/';
  static const String routeHome = '/home';
  static const String routeLogin = '/login';
  static const String routeCounter = '/counter';
  static const String routeCourseList = '/coure_list';
  static const String routeCourseDetail = '/course_detail';

  ///#endregion

  static final AppRoute _instance = AppRoute._private();

  static AppRoute get I => _instance;

  /// Create local provider
  // MaterialPageRoute<dynamic>(
  //             settings: settings,
  //             builder: (_) => AppRoute.createProvider(
  //                 (_) => HomeProvider(),
  //                 HomePage(
  //                   status: settings.arguments as bool,
  //                 )))
  static Widget createProvider<P extends ChangeNotifier>(
    P Function(BuildContext context) provider,
    Widget child,
  ) {
    return ChangeNotifierProvider<P>(
      create: provider,
      builder: (_, __) {
        return child;
      },
    );
  }

  /// App route observer
  final RouteObserver<Route<dynamic>> routeObserver =
      RouteObserver<Route<dynamic>>();

  /// App global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Get app context
  BuildContext get appContext => navigatorKey.currentContext;

  /// Generate route for app here
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeCounter:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) => AppRoute.createProvider(
                (_) => CounterProvider(),
                CounterPage(
                  argument: settings.arguments as String,
                )));

      case routeHome:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const HomePage());

      case routeRoot:
      case routeLogin:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const LoginPage());

      case routeCourseList:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const CourseListPage());

      case routeCourseDetail:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => CourseDetailPage(course: settings.arguments as Map<String, Object>));

      default:
        return null;
    }
  }
}
