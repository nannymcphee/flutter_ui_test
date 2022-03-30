import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/netflix_clone/home/home_provider.dart';
import 'package:nft/pages/netflix_clone/json/home_json.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_style.dart';
import 'package:provider/provider.dart';

class NetflixHomePage extends StatefulWidget {
  const NetflixHomePage({Key key}) : super(key: key);

  @override
  _NetflixHomePageState createState() => _NetflixHomePageState();
}

class _NetflixHomePageState extends PageStateful<NetflixHomePage>
    with WidgetsBindingObserver, RouteAware {

  int count = 0;

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

    WidgetsBinding.instance.addPostFrameCallback((_ ) {

    });
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.H),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _buildFeaturedMovieSection(),
                      _buildHeader(),
                    ],
                  ),
                  _buildSectionTitle('My List'),
                  _buildMovieListCards(mylist, false),
                  _buildSectionTitle('Popular'),
                  _buildMovieListCards(popularList, false),
                  _buildSectionTitle('Trending'),
                  _buildMovieListCards(trendingList, false),
                  _buildSectionTitle('Netflix Originals'),
                  _buildMovieListCards(originalList, true),
                  _buildSectionTitle('Anime'),
                  _buildMovieListCards(animeList, false),
                ],
              ),
            ),
          )
          // _buildHeader(),
          // _buildFeaturedMovieSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 44.H, left: 20.W),
      width: MediaQuery.of(context).size.width,
      height: 130.H,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.black,
                Colors.transparent
              ]
          )
      ),
      // color: Colors.red,
      child: Stack(
        children: <Widget>[
          Image.asset(appTheme.assets.icNetflixLogo,
              fit: BoxFit.fitWidth, height: 36.H, width: 36.W),
          Positioned(
            right: 20.W,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.cast_outlined,
                        color: Colors.white, size: 26.H),
                    onPressed: () {
                      print('Pressed cast');
                    }),
                SizedBox(width: 15.W),
                Container(
                    width: 30.W,
                    height: 30.H,
                    child: Image.asset(
                      'assets/app/icons/banner.webp', fit: BoxFit.cover,)
                )
              ],
            ),
          ),
          Positioned(
            bottom: 15.H,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'TV Shows',
                    style: normalTextStyle(14.W, color: Colors.white),
                  ),
                  Text(
                    'Movies',
                    style: normalTextStyle(14.W, color: Colors.white),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Categories',
                        style: normalTextStyle(14.W, color: Colors.white),
                      ),
                      Icon(
                          Icons.arrow_drop_down,
                          size: 24.H,
                          color: Colors.white),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFeaturedMovieSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 13/16,
      // color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                    'assets/app/icons/banner.webp')
              )
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 250.H,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Colors.black,
                        Colors.transparent
                      ]
                  )
              ),
            ),
          ),
          Positioned(
            bottom: 70.H,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/app/icons/title_img.webp',
                    width: 300,
                  ),
                  SizedBox(height: 15.H),
                  Text(
                    'Exciting - Sci-Fi Drama - Sci-Fi Adventure',
                    style: normalTextStyle(13.H, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print('Tapped My List');
                    },
                    child: Container(
                      width: 80.W,
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          SizedBox(height: 4.H),
                          Text(
                            'My List',
                            style: normalTextStyle(14.H, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Tapped Play');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.W),
                      height: 30.H,
                      // width: 100.W,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3.H),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 30.H,
                          ),
                          Text(
                            'Play',
                            style: semiBoldTextStyle(14.H, color: Colors.black),
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
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMovieListCards(List<Map<Object, String>> items, bool isOriginals) {
    return Container(
      height: isOriginals ? 280.H : 150.H,
      padding: EdgeInsets.symmetric(horizontal: 10.W),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items.mapIndexed((int index, Map<Object, String> value) {
          return Container(
            margin: EdgeInsets.only(right: 10.W),
            width: isOriginals ? 150.W : 110.W,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.H),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  value['img'],
                )
              )
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.only(top: 20.H, bottom: 10.H, left: 10.W),
      child: Text(
        title,
        style: boldTextStyle(16.H, color: Colors.white),
      ),
    );
  }
}
