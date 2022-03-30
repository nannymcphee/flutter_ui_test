import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/netflix_clone/coming_soon/coming_soon_page.dart';
import 'package:nft/pages/netflix_clone/downloads/downloads_page.dart';
import 'package:nft/pages/netflix_clone/home/home_page.dart';
import 'package:nft/pages/netflix_clone/json/root_app_json.dart';
import 'package:nft/pages/netflix_clone/search/search_page.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_style.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends PageStateful<RootPage>
    with WidgetsBindingObserver, RouteAware {

  int _selectedIndex = 0;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
  }

  @override
  void afterFirstBuild(BuildContext context) {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRoute.I.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AppRoute.I.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Log app life cycle state
    logger.d(state);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    initDynamicSize(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: IndexedStack(
          index: _selectedIndex,
          children: const <Widget>[
            NetflixHomePage(),
            ComingSoonPage(),
            SearchPage(),
            DownloadsPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 80.H,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: bottomNavItems.mapIndexed((int index, Map<Object, Object> item) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.only(top: 10.H),
              width: (MediaQuery.of(context).size.width - 40.W) / bottomNavItems.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    item['icon'] as IconData,
                    color: (_selectedIndex == index) ? Colors.white : Colors.white54,
                  ),
                  SizedBox(height: 4.H),
                  Text(
                    item['text'] as String,
                    textAlign: TextAlign.center,
                    style: normalTextStyle(10.H,
                        color: _selectedIndex == index ? Colors.white : Colors.white54),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}