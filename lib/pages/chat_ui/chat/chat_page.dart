import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/models/local/user.dart';
import 'package:nft/pages/chat_ui/chat/chat_provider.dart';
import 'package:nft/pages/chat_ui/widgets/w_message_list.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_style.dart';
import '../../../widgets/w_keyboard_dismiss.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends PageStateful<ChatPage>
    with WidgetsBindingObserver, RouteAware {

  // Provider
  ChatProvider _chatProvider;

  FocusNode _inputFocusNode;
  final TextEditingController _inputController = TextEditingController(text: '');

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
      _chatProvider = context.read<ChatProvider>();
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

  void clearMessageInputText() {
    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    initDynamicSize(context);

    return Consumer<ChatProvider>(
      builder: (BuildContext context, ChatProvider provider, _) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.black,
            body: AnimatedContainer(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom ),
              child: SafeArea(
                bottom: false,
                top: false,
                child: WKeyboardDismiss(
                  child: Container(
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildHeader(provider.receiver),
                          WMessageList(user: provider.receiver),
                          _buildInputBar(provider),
                        ],
                      )
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildHeader(User user) {
    return Container(
      height: 54.H + MediaQuery.of(context).padding.top,
      color: Colors.grey.withOpacity(0.1),
      padding: EdgeInsets.only(left: 10.W, right: 10.W, top: MediaQuery.of(context).padding.top.H - 10.H),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              context.navigator().pop();
            },
            splashRadius: 20.W,
            icon: Icon(Icons.arrow_back_ios_outlined,
                color: Colors.white, size: 24.H),
          ),
          Container(
            width: 32.W,
            height: 32.H,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(user.avatar)
                )
            ),
          ),
          SizedBox(width: 10.W),
          Flexible(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.name,
                    style: semiBoldTextStyle(14.H, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.H),
                  Text(
                    'Active now',
                    style: normalTextStyle(12.H, color: Colors.grey.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputBar(ChatProvider provider) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54.H + MediaQuery.of(context).padding.bottom,
      color: Colors.grey.withOpacity(0.1),
      child: Container(
        padding: EdgeInsets.all(10.H),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.only(right: 10.W),
                child: IconButton(
                  onPressed: () {
                    print('Pressed Gallery');
                  },
                  icon: Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: Colors.blue,
                    size: 24.H,
                  ),
                  splashRadius: 16.W,
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.W),
                height: 40.H,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.H),
                ),
                child: TextField(
                  focusNode: _inputFocusNode,
                  controller: _inputController,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Aa',
                    hintStyle: normalTextStyle(14.W, color: Colors.grey.withOpacity(0.7)),
                  ),
                  style: normalTextStyle(14.W, color: Colors.white),
                  textInputAction: TextInputAction.send,
                  onChanged: (String message) {
                    provider.onMessageTextChangeToValidateMessage(message);
                  },
                  onSubmitted: (_) {
                    if (provider.messageValid) {
                      provider.sendMessage();
                      provider.onSendMessageSuccess();
                      clearMessageInputText();
                    }
                  },
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.W),
                child: IconButton(
                  onPressed: () {
                    if (provider.messageValid) {
                      provider.sendMessage();
                      provider.onSendMessageSuccess();
                      clearMessageInputText();
                    }
                  },
                  icon: Icon(
                    Icons.send_outlined,
                    color: Colors.blue,
                    size: 24.H,
                  ),
                  splashRadius: 16.W,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
