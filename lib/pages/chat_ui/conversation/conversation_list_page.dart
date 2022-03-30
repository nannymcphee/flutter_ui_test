import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/models/local/user.dart';
import 'package:nft/pages/chat_ui/chat/chat_provider.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_style.dart';

class ConversationListPage extends StatefulWidget {
  const ConversationListPage({Key key}) : super(key: key);

  @override
  _ConversationListPageState createState() => _ConversationListPageState();
}

class _ConversationListPageState extends PageStateful<ConversationListPage>
    with WidgetsBindingObserver, RouteAware {
  FocusNode _inputFocusNode;

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
    _inputFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_inputFocusNode);
      _inputFocusNode.unfocus();
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
      appBar: _buildAppBar(),
      backgroundColor: Colors.black,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildRecentChatList(),
        ],
      )),
    );
  }

  Widget _buildRecentChatList() {
    return Flexible(
      child: ListView.builder(
        itemCount: allChats.length,
        itemBuilder: (BuildContext context, int index) {
          final MessageBase chat = allChats[index];
          return InkWell(
            onTap: () {
              context.read<ChatProvider>().receiver = chat.sender;
              context.read<ChatProvider>().currentSender = currentUser;
              context.navigator().pushNamed(AppRoute.routeChatDetail);
            },
            child: Container(
              margin: EdgeInsets.only(
                  top: 5.H, left: 20.W, right: 20.W, bottom: 5.H),
              width: MediaQuery.of(context).size.width,
              height: 70.H,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60.W,
                    height: 60.H,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: AssetImage(chat.avatar))),
                  ),
                  SizedBox(width: 10.W),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (chat.isRead)
                          Text(
                            chat.sender.name,
                            style: semiBoldTextStyle(16.W, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                chat.sender.name,
                                style: semiBoldTextStyle(16.W, color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                width: 10.W,
                                height: 10.H,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              )
                            ],
                          ),
                        SizedBox(height: 4.H),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                chat.text,
                                style: chat.isRead
                                    ? normalTextStyle(12.W,
                                        color: Colors.grey.withOpacity(0.7))
                                    : boldTextStyle(12.W, color: Colors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              ' - ${chat.time}',
                              style: chat.isRead
                                  ? normalTextStyle(12.W,
                                      color: Colors.grey.withOpacity(0.7))
                                  : boldTextStyle(12.W, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: Colors.grey.withOpacity(0.1),
      leading: Padding(
        padding: EdgeInsets.only(left: 20.W),
        child: Container(
          width: 32.W,
          height: 32.H,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(currentUser.avatar))),
        ),
      ),
      title: Text(
        'Chats',
        style: boldTextStyle(20.H, color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.W),
          child: Material(
            color: Colors.transparent,
            child: Container(
              child: IconButton(
                onPressed: () {
                  print('Pressed New message');
                },
                icon: Icon(
                  Icons.message_outlined,
                  color: Colors.white,
                  size: 24.H,
                ),
                splashRadius: 20.W,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
