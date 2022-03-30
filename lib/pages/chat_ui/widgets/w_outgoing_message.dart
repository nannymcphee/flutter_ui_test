import 'package:flutter/material.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/pages/chat_ui/chat/chat_provider.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../../services/app/dynamic_size.dart';
import '../../../utils/app_style.dart';

class WOutgoingMessage extends StatelessWidget with DynamicSize {
  const WOutgoingMessage({Key key, this.message, this.index}) : super(key: key);

  final MessageBase message;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isMessageTopLabelVisible =
    context.read<ChatProvider>().isMessageTopLabelVisible(index);
    final bool isMessageLeftLabelVisible =
    !context.read<ChatProvider>().isPreviousMessageSameSender(index);
    final bool isMessageBottomLabelVisible =
    !context.read<ChatProvider>().isPreviousMessageSameSender(index);
    final bool isAvatarVisible =
    context.read<ChatProvider>().isAvatarVisible(index);

    final TextStyle timeLabelTextStyle =
    normalTextStyle(10.H, color: Colors.grey.withOpacity(0.7));
    final Color messageBubbleBackgroundColor = Colors.blue;
    final double outgoingAvatarSize = isAvatarVisible ? 24.W : 0;
    final EdgeInsets outgoingAvatarMargin =
    isAvatarVisible ? EdgeInsets.only(left: 10.W) : EdgeInsets.zero;
    final EdgeInsets messageBottomLabelPadding = EdgeInsets.only(
        top: 5.H, right: outgoingAvatarSize + outgoingAvatarMargin.horizontal);
    final double spacingBetweenMessages =
    context.read<ChatProvider>().isPreviousMessageSameSender(index)
        ? 3.H
        : 10.H;

    return Container(
      padding: EdgeInsets.only(bottom: spacingBetweenMessages),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Message top label
          Container(
            width: MediaQuery.of(context).size.width,
            height: isMessageTopLabelVisible ? null : 0.H,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.H),
                  child: Text(
                    '${message.time} 02/04/2021',
                    style: timeLabelTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          /// Main message row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              /// Message left label
              Container(
                height: isMessageLeftLabelVisible ? null : 0,
                padding: isMessageLeftLabelVisible
                    ? EdgeInsets.only(right: 4.W)
                    : EdgeInsets.zero,
                child: Text(
                  message.time,
                  style: timeLabelTextStyle,
                ),
              ),

              /// Message text bubble
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 14.W),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                decoration: BoxDecoration(
                  color: messageBubbleBackgroundColor,
                  borderRadius: BorderRadius.circular(8.H),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.H),
                  child: Text(
                    message.text,
                    style: normalTextStyle(14.H, color: Colors.white),
                  ),
                ),
              ),

              /// Avatar view
              Container(
                  margin: outgoingAvatarMargin,
                  width: outgoingAvatarSize,
                  height: outgoingAvatarSize,
                  child: isAvatarVisible
                      ? CircleAvatar(
                      backgroundImage: AssetImage(message.sender.avatar),
                      radius: outgoingAvatarSize / 2)
                      : null),
            ],
          ),

          /// Message bottom row
          Container(
            height: isMessageBottomLabelVisible ? null : 0,
            padding: messageBottomLabelPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  message.isRead ? 'Seen' : 'Received',
                  style: timeLabelTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
