import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/pages/course_list//w_course_item.dart';
import 'package:nft/pages/course_list/w_for_you_item.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_constants.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/demo_constrants.dart';
import 'package:provider/provider.dart';
import '../../utils/app_style.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key key}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends PageStateful<CourseListPage>
    with WidgetsBindingObserver, RouteAware {
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          color: Colors.deepPurple,
          child: Column(
            children: <Widget>[
              _buildHeader(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 35.H, right: 10.W, left: 20.W),
          width: 50.W,
          height: 50.H,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.W),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://unsplash.com/photos/Y7C7F26fzZM/download?force=true&w=640',
                ),
                fit: BoxFit.cover,
              )),
        ),
        Container(
          padding: EdgeInsets.only(top: 60.H, right: 17.W, bottom: 30.H),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hi, Davis',
                style: boldTextStyle(28.W, color: Colors.white),
              ),
              SizedBox(height: 4.H),
              Text(
                'learning is easier and faster with us.',
                style: normalTextStyle(16.W, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.W),
                topRight: Radius.circular(35.W))),
        child: CustomScrollView(
          slivers: <Widget>[
            _buildSectionTitle('Top courses'),
            _buildTopCoursesSection(),
            _buildSectionTitle('For you'),
            _buildForYouSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20.W),
        child: Text(
          title,
          style: normalTextStyle(35.H, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildTopCoursesSection() {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 205.H,
        child: PageView(
          controller: PageController(
            viewportFraction: 0.85,
            initialPage: 2,
          ),
          children: topCoursesList.map((Map<String, Object> course) {
            return WCourseItem(
              onTap: () {
                context.navigator().pushNamed(AppConstant.courseDetailPageRoute, arguments: course);
              },
              color: course['color'] as Color,
              rating: course['rating'] as String,
              title: course['title'] as String,
              image: course['image'] as String,
              teacher: course['teacher'] as String,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildForYouSection() {
    return SliverPadding(
      padding: EdgeInsets.only(left: 20.W, right: 20.W, bottom: 44.H),
      sliver: SliverGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 24.H,
        crossAxisSpacing: 16.W,
        childAspectRatio: 0.95,
        children: forYouList.map((Map<String, Object> course) {
          return WForYouItem(
            onTap: () {
              context.navigator().pushNamed(AppConstant.courseDetailPageRoute, arguments: course);
            },
            color: course['color'] as Color,
            rating: course['rating'] as String,
            title: course['title'] as String,
            image: course['image'] as String,
            teacher: course['teacher'] as String,
          );
        }).toList(),
      ),
    );
  }
}
