import 'package:flutter/material.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/pages/chat_ui/chat/chat_provider.dart';
import 'package:nft/pages/chat_ui/chat/message_style.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:provider/provider.dart';

import '../../../services/app/dynamic_size.dart';

class WMessageContainer extends StatelessWidget with DynamicSize {
  const WMessageContainer(
      {Key key,
      this.message,
      @required this.index,
      @required this.messageStyle,
      @required this.child})
      : super(key: key);

  final MessageBase message;
  final int index;
  final MessageStyle messageStyle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      constraints:
          BoxConstraints(maxWidth: messageStyle.messageContainerMaxWidth),
      decoration: messageContainerDecoration(
          context: context, messageStyle: messageStyle, index: index),
      child: child,
    );
  }
}

BoxDecoration messageContainerDecoration(
    {@required BuildContext context,
    @required MessageStyle messageStyle,
    @required int index}) {
  final bool isFromCurrentSender =
      context.read<ChatProvider>().isFromCurrentSender(index);
  final bool isPreviousMessageSameSender =
      context.read<ChatProvider>().isPreviousMessageSameSender(index);
  final bool isNextMessageSameSender =
      context.read<ChatProvider>().isNextMessageSameSender(index);

  return BoxDecoration(
      color: messageStyle.messageContainerColor,
      borderRadius: () {
        if (isFromCurrentSender) {
          return BorderRadius.only(
              topLeft: Radius.circular(12.H),
              bottomLeft: Radius.circular(12.H),
              topRight: !isPreviousMessageSameSender
                  ? Radius.circular(12.H)
                  : Radius.circular(3.H),
              bottomRight: !isNextMessageSameSender
                  ? Radius.circular(12.H)
                  : Radius.circular(3.H));
        } else {
          return BorderRadius.only(
              topRight: Radius.circular(12.H),
              bottomRight: Radius.circular(12.H),
              topLeft: !isPreviousMessageSameSender
                  ? Radius.circular(12.H)
                  : Radius.circular(3.H),
              bottomLeft: !isNextMessageSameSender
                  ? Radius.circular(12.H)
                  : Radius.circular(3.H));
        }
      }());
}
