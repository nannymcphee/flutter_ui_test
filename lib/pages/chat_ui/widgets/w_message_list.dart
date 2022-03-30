import 'package:flutter/material.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/models/local/user.dart';
import 'package:nft/pages/chat_ui/chat/chat_provider.dart';
import 'package:nft/pages/chat_ui/chat/message_style.dart';
import 'package:nft/pages/chat_ui/widgets/w_message_base.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:provider/provider.dart';

import '../../../services/app/dynamic_size.dart';
import '../../../utils/app_style.dart';

class WMessageList extends StatefulWidget {
  const WMessageList({Key key, this.user}) : super(key: key);

  @override
  _WMessageListState createState() => _WMessageListState();

  final User user;
}

class _WMessageListState extends State<WMessageList> with DynamicSize {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottomIfNeeded(ChatProvider provider) {
    if (provider.canScrollToBottom) {
      _scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    initDynamicSize(context);
    return Consumer<ChatProvider>(
        builder: (BuildContext context, ChatProvider provider, _) {
      _scrollToBottomIfNeeded(provider);
      return Flexible(
        child: Container(
          color: Colors.black,
          child: ListView.builder(
            padding: EdgeInsets.all(10.H),
            reverse: true,
            controller: _scrollController,
            itemCount: provider.messageList.length,
            itemBuilder: (BuildContext context, int index) {
              final MessageBase message = provider.messageList[index];
              return WMessageBase(
                  message: message,
                  index: index,
                  messageStyle: getMessageStyle(index));
            },
          ),
        ),
      );
    });
  }

  MessageStyle getMessageStyle(int index) {
    return MessageStyle(
      outgoingAvatarWidth: 0.W,
      incomingAvatarWidth: 24.W,
      messageContainerColor:
          context.read<ChatProvider>().isFromCurrentSender(index)
              ? Colors.blue
              : Colors.grey.withOpacity(0.2),
      incomingAvatarMargin: EdgeInsets.only(right: 10.W),
      outgoingAvatarMargin: EdgeInsets.only(left: 0.W),
      textMessageStyle: normalTextStyle(14.H, color: Colors.white),
      messageContainerMaxWidth: MediaQuery.of(context).size.width * 0.7,
    );
  }
}
