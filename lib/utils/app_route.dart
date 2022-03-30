import 'package:flutter/material.dart';
import 'package:nft/pages/chat_ui/chat/chat_page.dart';
import 'package:nft/pages/chat_ui/conversation/conversation_list_page.dart';
import 'package:nft/pages/chat_ui/image_detail/image_detail_page.dart';
import 'package:nft/pages/chat_ui/widgets/w_images_message.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/counter/counter_provider.dart';
import 'package:nft/pages/course_detail/course_detail_page.dart';
import 'package:nft/pages/course_list/course_list_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/login/login_page.dart';
import 'package:nft/pages/netflix_clone/coming_soon/coming_soon_page.dart';
import 'package:nft/pages/netflix_clone/downloads/downloads_page.dart';
import 'package:nft/pages/netflix_clone/home/home_page.dart';
import 'package:nft/pages/netflix_clone/root/root_page.dart';
import 'package:nft/pages/netflix_clone/search/search_page.dart';
import 'package:nft/pages/netflix_clone/video_detail/video_detail_page.dart';
import 'package:provider/provider.dart';

class AppRoute {
  factory AppRoute() => _instance;

  AppRoute._private();

  ///#region ROUTE NAMES
  /// -----------------
  static const String routeRoot = '/';
  static const String routeHome = '/home';
  // static const String routeLogin = '/login';
  static const String routeCounter = '/counter';
  static const String routeCourseList = '/coure_list';
  static const String routeCourseDetail = '/course_detail';
  static const String routeNetflixRoot = '/netflix_clone/root';
  static const String routeNetflixHome = '/netflix_clone/home';
  static const String routeNetflixComingSoon = '/netflix_clone/coming_soon';
  static const String routeNetflixSearch = '/netflix_clone/search';
  static const String routeNetflixDownloads = '/netflix_clone/downloads';
  static const String routeNetflixVideoDetail = '/netflix_clone/video_detail';
  static const String routeChatDetail = '/chat_ui/chat';
  static const String routeConversationList = '/chat_ui/conversation';
  static const String routeImageDetail = '/chat_ui/image_detail';
  static const String routeSlidePage = 'chat_ui/image_detail';

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
      // case routeLogin:
      //   return MaterialPageRoute<dynamic>(
      //       settings: settings, builder: (_) => const LoginPage());

      case routeCourseList:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const CourseListPage());

      case routeCourseDetail:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => CourseDetailPage(course: settings.arguments as Map<String, Object>));

      case routeNetflixRoot:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const RootPage());

      case routeNetflixHome:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const NetflixHomePage());

      case routeNetflixComingSoon:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const ComingSoonPage());

      case routeNetflixSearch:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const SearchPage());

      case routeNetflixDownloads:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const DownloadsPage());

      case routeNetflixVideoDetail:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const VideoDetailPage());

      case routeChatDetail:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const ChatPage());

      case routeConversationList:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const ConversationListPage());

      case routeImageDetail:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const ImageDetailPage());

      // case routeSlidePage:
      //   return MaterialPageRoute<dynamic>(
      //       settings: settings, builder: (_) => const SlidePage());

      default:
        return null;
    }
  }
}
