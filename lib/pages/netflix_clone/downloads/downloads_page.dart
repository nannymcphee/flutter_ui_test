import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../utils/app_style.dart';
import '../../../utils/app_style.dart';
import '../../../utils/app_style.dart';
import '../../../utils/app_style.dart';
import '../../../widgets/w_button_inkwell.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({Key key}) : super(key: key);

  @override
  _DownloadsPageState createState() => _DownloadsPageState();
}

class _DownloadsPageState extends PageStateful<DownloadsPage>
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
              _buildFooter(),
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
                'My Downloads',
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
                      print('Pressed Cast');
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

  Widget _buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print('Tapped Smart Downloads');
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40.H,
            color: Colors.grey.withOpacity(0.2),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.W),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.info_outline_rounded,
                    size: 20.H,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.W),
                  RichText(
                    text: TextSpan(
                      text: 'Smart Downloads',
                      style: semiBoldTextStyle(12.H, color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ON',
                          style: semiBoldTextStyle(12.H, color: Colors.blue),
                        )
                      ]
                    )
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 30.W),
          child: Column(
            children: <Widget>[
              SizedBox(height: 60.H),
              Container(
                width: 160.W,
                height: 160.H,
                padding: EdgeInsets.symmetric(horizontal: 30.W),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Icon(
                  AntDesign.download,
                  size: 90.H,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 30.H),
              Text(
                'Never be without Netflix',
                style: boldTextStyle(18.H, color: Colors.white.withOpacity(0.9)),
              ),
              SizedBox(height: 10.H),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.W),
                child: Text(
                  'Download shows and movies so you\'ll never be without something to watch - even when you\'re offline',
                  style: normalTextStyle(15.H, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30.H),
              WButtonInkwell(
                size: Size(220.W, 40.H),
                backgroundColor: Colors.white.withOpacity(0.9),
                splashColor: Colors.grey.withOpacity(0.3),
                onPressed: () {
                  print('Pressed download');
                },
                title: Text(
                  'See What You Can Download',
                  style: semiBoldTextStyle(14.W, color: Colors.black),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}