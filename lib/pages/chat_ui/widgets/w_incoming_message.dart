import 'package:flutter/material.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/models/local/user.dart';
import 'package:nft/pages/chat_ui/chat/chat_provider.dart';
import 'package:nft/utils/app_asset.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../../services/app/dynamic_size.dart';
import '../../../utils/app_style.dart';

class WIncomingMessage extends StatelessWidget with DynamicSize {
  const WIncomingMessage({Key key, this.message, this.index}) : super(key: key);

  final MessageBase message;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isMessageTopLabelVisible =
    context.read<ChatProvider>().isMessageTopLabelVisible(index);
    final bool isMessageRightLabelVisible =
    !context.read<ChatProvider>().isPreviousMessageSameSender(index);
    final bool isMessageBottomLabelVisible =
    !context.read<ChatProvider>().isPreviousMessageSameSender(index);
    final bool isAvatarVisible =
    context.read<ChatProvider>().isAvatarVisible(index);

    final TextStyle timeLabelTextStyle =
    normalTextStyle(10.H, color: Colors.grey.withOpacity(0.7));
    final Color messageBubbleBackgroundColor = Colors.grey.withOpacity(0.2);
    final double incomingAvatarSize = 24.W;
    final EdgeInsets incomingAvatarMargin = EdgeInsets.only(right: 10.W);
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              /// Avatar view
              Container(
                  margin: incomingAvatarMargin,
                  width: incomingAvatarSize,
                  height: incomingAvatarSize,
                  child: isAvatarVisible
                      ? CircleAvatar(
                      backgroundImage: AssetImage(message.sender.avatar),
                      radius: incomingAvatarSize / 2)
                      : null),

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

              /// Message right label
              Container(
                padding: isMessageRightLabelVisible
                    ? EdgeInsets.only(left: 4.W)
                    : EdgeInsets.zero,
                height: isMessageRightLabelVisible ? null : 0,
                child: Text(
                  message.time,
                  style: timeLabelTextStyle,
                ),
              ),
            ],
          ),

          /// Message bottom row
          Container(
            height: isMessageBottomLabelVisible ? null : 0,
            padding: EdgeInsets.only(
                top: 5.H,
                left: incomingAvatarSize + incomingAvatarMargin.horizontal),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
