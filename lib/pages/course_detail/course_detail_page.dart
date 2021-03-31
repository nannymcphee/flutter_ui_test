import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/pages/course_detail/w_course_content.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/widgets/w_button_inkwell.dart';

import '../../utils/app_style.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({Key key, this.course}) : super(key: key);

  final Map<String, Object> course;

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends PageStateful<CourseDetailPage>
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
              _buildBackButton(),
              SizedBox(height: 20.H),
              _buildDetailSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(top: 54.H, left: 20.W),
      child: GestureDetector(
        onTap: () {
          context.navigator().pop();
        },
        child: Row(
          children: <Widget>[
            Icon(
                Icons.arrow_back_ios,
                size: 25.H,
                color: Colors.white
            ),
            SizedBox(width: 4.W),
            Text(
              'Back',
              style: normalTextStyle(16.W, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection() {
    return Expanded(
      child: Container(
          padding: EdgeInsets.only(left: 20.H, right: 20.W),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.W),
                topRight: Radius.circular(35.W))),
        child: CustomScrollView(
          slivers: <Widget>[
            _buildCourseTitleSection(),
            _buildSectionTitle('The Course includes'),
            _buildCourseContentCard(),
            _buildSectionTitle('Teacher'),
            _buildTeacherInfoCard(),
            _buildStartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 20.H, right: 20.W, bottom: 20.H),
        child: Text(
          title,
          style: normalTextStyle(20.H, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildCourseTitleSection() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(top: 20.H),
        child: Row(
          children: <Widget>[
            Container(
              width: 80.W,
              height: 80.H,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.W),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://github.com/flutterbytes/flutter_glassmorphism/blob/master/assets/images/bg.jpg?raw=true',
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(width: 20.W),
            Flexible(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.course['title'] as String,
                      style: semiBoldTextStyle(24.W, color: Colors.black),
                    ),
                    SizedBox(height: 4.H),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 5.W),
                          child: const Icon(
                            Icons.star,
                            color: Colors.deepOrange,
                            size: 24,
                          ),
                        ),
                        Text(
                          widget.course['rating'] as String,
                          style: normalTextStyle(15.W, color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseContentCard() {
    return SliverToBoxAdapter(
      child: Container(
        height: 260.H,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.W),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(1, 2),
              )
            ]
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.H),
              child: WCourseContent(
                color: Colors.deepPurple,
                icon: Icon(Icons.videocam_outlined, color: Colors.white, size: 30.H),
                title: '12 Video Tutorials',
                highlightedSubtitle: '250 mins',
                normalSubtitle: ' of interesting lectures',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.W, right: 20.W, bottom: 20.H),
              child: WCourseContent(
                color: Colors.teal,
                icon: Icon(Icons.bookmark_outlined, color: Colors.white, size: 30.H),
                title: '7 Practical Tasks',
                highlightedSubtitle: '3 teachers',
                normalSubtitle: ' will check your work',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.W, right: 20.W, bottom: 20.H),
              child: WCourseContent(
                color: Colors.pinkAccent,
                icon: Icon(Icons.bookmark_outlined, color: Colors.white, size: 30.H),
                title: '10 Templates For Design',
                highlightedSubtitle: '500 MB',
                normalSubtitle: ' of Sketch files',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherInfoCard() {
    return SliverToBoxAdapter(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.H,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.W),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(1, 2),
              )
            ]
        ),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: widget.course['image'] as String,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.W),
                    width: 70.W,
                    height: 70.H,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.W),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.course['image'] as String,
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            widget.course['teacher'] as String,
                            style: boldTextStyle(18.W, color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.H),
                      Text(
                        'Designer',
                        style: normalTextStyle(14.W, color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.W),
              ],
            ),
            Positioned(
              top: 20.H,
              right: 20.W,
              child: Icon(
                  Icons.arrow_right_alt_sharp,
                  color: Colors.deepPurpleAccent,
                  size: 40.W),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 30.H, bottom: 44.H),
        child: WButtonInkwell(
          onPressed: () {
            print('Tapped Start');
          },
          backgroundColor: Colors.black.withOpacity(0.8),
          size: Size(
            MediaQuery.of(context).size.width,
            50.H
          ),
          borderRadius: BorderRadius.circular(25.H),
          title: Text(
            'Start',
            style: boldTextStyle(18.H, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
