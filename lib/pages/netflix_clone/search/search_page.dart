import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_style.dart';
import 'package:nft/widgets/p_material.dart';
import 'package:nft/widgets/w_keyboard_dismiss.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_style.dart';
import '../json/search_json.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends PageStateful<SearchPage>
    with WidgetsBindingObserver, RouteAware {
  FocusNode _searchFocusNode;

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
    _searchFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
      _searchFocusNode.unfocus();
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
    _searchFocusNode.dispose();
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

    return WKeyboardDismiss(
      child: PMaterial(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            bottom: false,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSearchBar(),
                  _buildTopSearchList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSearchBar() {
    return Padding(
      padding:
      EdgeInsets.only(left: 10.W, right: 10.W, bottom: 20.H),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40.H,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.H),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.W),
          child: TextField(
            style:
            normalTextStyle(14.W, color: Colors.white70),
            focusNode: _searchFocusNode,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: normalTextStyle(14.H,
                    color: Colors.grey.withOpacity(0.7)),
                prefixIcon: Icon(
                  Icons.search,
                  size: 24.H,
                  color: Colors.grey.withOpacity(0.7),
                )),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTopSearchList() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.W),
              child: Text(
                'Top Searches',
                style: boldTextStyle(14.W, color: Colors.white),
              ),
            ),
            SizedBox(height: 10.H),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.W),
              shrinkWrap: true,
              primary: false,
              itemCount: topSearchList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    print('Tapped search item');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.H),
                    width: MediaQuery.of(context).size.width,
                    height: 100.H,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 100.H,
                          width: 120.H,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.H),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    topSearchList[index]['img'],
                                  )
                              )
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.W),
                                  child: Text(
                                    topSearchList[index]['title'],
                                    style: semiBoldTextStyle(14.W, color: Colors.white),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  print('Tapped play button');
                                },
                                splashRadius: 30.H,
                                iconSize: 40.H,
                                icon: const Icon(
                                  Icons.play_circle_outline_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
