import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:provider/provider.dart';

import '../../utils/app_style.dart';
import '../../widgets/p_appbar_transparency.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends PageStateful<HomePage>
    with WidgetsBindingObserver, RouteAware {
  HomeProvider homeProvider;

  List<String> courseNames = <String>['Reading', 'Listening', 'Writing', 'Vocabulary', 'Grammar'];


  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    homeProvider = Provider.of(context, listen: false);
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
  void didPush() {
    /// Called when the current route has been pushed.
    logger.d('didPush');
  }

  @override
  void didPopNext() {
    /// Called when the top route has been popped off, and the current route
    /// shows up.
    logger.d('didPopNext');
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

    return PAppBarTransparency(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildHeader(),
              _buildQuestionCard(),
              _buildPopularCourses(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(17.W, 60.H, 17.W, 30.H),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello, Lisa',
                style: boldTextStyle(28.W, color: Colors.black),
              ),
              SizedBox(height: 8.H),
              Text(
                'Beginner',
                style:
                    normalTextStyle(16.W, color: Colors.black.withOpacity(0.4)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.H, right: 17.W),
          width: 50.W,
          height: 50.H,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(appTheme.assets.icProfilePlaceholder),
        )
      ],
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      margin: EdgeInsets.only(left: 17.W, right: 17.W, bottom: 30.H),
      width: MediaQuery.of(context).size.width,
      height: 250.H,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.H),
          // color: Colors.lightBlue.withOpacity(0.6),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: const Offset(0, 2),
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1.0,
                blurRadius: 5.0)
          ]),
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250.H,
            decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10.H)),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.H, left: 20.W, right: 20.W),
            child: Text(
              'What do you want\nto learn today?',
              style: boldTextStyle(20.H, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCourses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 17.W),
          child: Text(
            'Popular courses',
            style: boldTextStyle(18.W, color: Colors.black),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 17.W),
          child: GridView.count(
            mainAxisSpacing: 20.H,
            crossAxisSpacing: 10.W,
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: courseNames.mapIndexed((int index, _) {
              return _buildCourseCard(index);
            }),
          ),
        )
      ],
    );
  }

  // Widget _buildPopularCourses() {
  //   return StaggeredGridView.countBuilder(
  //     crossAxisCount: 4,
  //     itemCount: 8,
  //     itemBuilder: (BuildContext context, int index) => Container(
  //         color: Colors.green,
  //         child: Center(
  //           child: CircleAvatar(
  //             backgroundColor: Colors.white,
  //             child: Text('$index'),
  //           ),
  //         )),
  //     staggeredTileBuilder: (int index) =>
  //     StaggeredTile.count(2, index.isEven ? 2 : 1),
  //     mainAxisSpacing: 4.0,
  //     crossAxisSpacing: 4.0,
  //   );
  // }

  Widget _buildCourseCard(int index) {
    final Random random = Random();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.H),
      ),
      child: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.H),
                color: Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.H, left: 15.W, right: 15.W),
            child: Text(
              courseNames[index],
              style: boldTextStyle(14.W, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

}
