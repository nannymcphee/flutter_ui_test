import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nft/pages/netflix_clone/json/coming_soon_json.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_style.dart';
import 'package:provider/provider.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({Key key}) : super(key: key);

  @override
  _ComingSoonPageState createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends PageStateful<ComingSoonPage>
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

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              _buildListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.H,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5.H,
            child: Padding(
              padding: EdgeInsets.only(left: 20.W),
              child: Text(
                'Coming Soon',
                style: boldTextStyle(24.H, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 20.W,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.cast_outlined,
                        color: Colors.white, size: 26.H),
                    onPressed: () {
                      print('Pressed airplay');
                    }),
                SizedBox(width: 15.W),
                Container(
                    width: 30.W,
                    height: 30.H,
                    child: Image.asset(
                      'assets/app/icons/banner.webp', fit: BoxFit.cover)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Flexible(
      child: Container(
        child: ListView.builder(
          itemCount: comingSoonList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(top: 5.H, bottom: 20.H),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 200.H,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          comingSoonList[index]['img'] as String,
                        )
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.W),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150.W,
                          height: 80.H,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    comingSoonList[index]['title_img'] as String,
                                  )
                              )
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print('Tapped Remind Me');
                              },
                              child: Container(
                                width: 80.W,
                                child: Column(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.notifications_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 4.H),
                                    Text(
                                      'Remind Me',
                                      style: normalTextStyle(14.H, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('Tapped Info');
                              },
                              child: Container(
                                width: 80.W,
                                child: Column(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.info_outline_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 4.H),
                                    Text(
                                      'Info',
                                      style: normalTextStyle(14.H, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10.W, 4.H, 10.W, 10.H),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          comingSoonList[index]['date'] as String,
                          style: normalTextStyle(14.W, color: Colors.white54),
                        ),
                        SizedBox(height: 10.H),
                        Text(
                          comingSoonList[index]['title'] as String,
                          style: boldTextStyle(16.W, color: Colors.white),
                        ),
                        SizedBox(height: 4.H),
                        Text(
                          comingSoonList[index]['description'] as String,
                          style: normalTextStyle(14.W, color: Colors.white54),
                        ),
                        SizedBox(height: 10.H),
                        Text(
                          comingSoonList[index]['type'] as String,
                          style: normalTextStyle(14.W, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}