import 'package:flutter/material.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/pages/chat_ui/chat/chat_provider.dart';
import 'package:nft/pages/chat_ui/chat/message_style.dart';
import 'package:nft/pages/chat_ui/widgets/w_images_message.dart';
import 'package:nft/pages/chat_ui/widgets/w_reminder_message.dart';
import 'package:nft/pages/chat_ui/widgets/w_text_message.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../../services/app/dynamic_size.dart';
import '../../../utils/app_style.dart';

class WMessageBase extends StatelessWidget with DynamicSize {
  const WMessageBase({Key key, this.message, this.index, this.messageStyle})
      : super(key: key);

  final MessageBase message;
  final int index;
  final MessageStyle messageStyle;

  @override
  Widget build(BuildContext context) {
    final bool isFromCurrentSender =
        context.read<ChatProvider>().isFromCurrentSender(index);
    final double spacingBetweenMessages =
        context.read<ChatProvider>().isNextMessageSameSender(index)
            ? 2.H
            : 20.H;
    final MainAxisAlignment messageRowMainAxisAlignment =
        isFromCurrentSender ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Container(
      padding: EdgeInsets.only(bottom: spacingBetweenMessages),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Message top label
          _buildMessageTopLabel(context: context),

          /// Time label
          _buildTimeLabel(context: context),

          /// Message that is not wrapped in WMessageContainer
          if (message is ReminderMessage)
            WReminderMessage(
              message: message as ReminderMessage,
              index: index,
              messageStyle: messageStyle,
            )
          else

            /// Main message row
            Row(
              mainAxisAlignment: messageRowMainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                /// Message accessory view for outgoing message
                if (isFromCurrentSender)
                  _buildOutgoingMessageAccessoryView(context: context),

                /// Avatar view for incoming message
                if (!isFromCurrentSender)
                  _buildIncomingMessageAvatarView(context: context),

                /// Message that is wrapped in WMessageContainer
                if (message is ImageMessage)
                  WImagesMessage(
                      message: message as ImageMessage,
                      index: index,
                      messageStyle: messageStyle)
                else
                  WTextMessage(
                    message: message,
                    index: index,
                    messageStyle: messageStyle,
                  ),

                /// Message accessory view for incoming message
                if (!isFromCurrentSender)
                  _buildIncomingMessageAccessoryView(context: context),

                /// Avatar view for outgoing message
                if (isFromCurrentSender)
                  _buildOutgoingMessageAvatarView(context: context),
              ],
            ),

          /// Message bottom row
          _buildMessageBottomRow(context: context),
        ],
      ),
    );
  }

  /// Build Message Top Label
  Widget _buildMessageTopLabel({BuildContext context}) {
    final bool isMessageTopLabelVisible =
        context.read<ChatProvider>().isMessageTopLabelVisible(index);
    final TextStyle timeLabelTextStyle =
        normalTextStyle(11.H, color: Colors.grey.withOpacity(0.7));
    final bool isFromCurrentSender =
        context.read<ChatProvider>().isFromCurrentSender(index);
    final EdgeInsets messageBottomLabelPadding = isFromCurrentSender
        ? EdgeInsets.only(
            top: 5.H,
            bottom: 5.H,
            right: messageStyle.outgoingAvatarWidth +
                messageStyle.outgoingAvatarMargin.horizontal)
        : EdgeInsets.only(
            top: 5.H,
            bottom: 5.H,
            left: messageStyle.incomingAvatarWidth +
                messageStyle.incomingAvatarMargin.horizontal);
    final MainAxisAlignment messageRowMainAxisAlignment =
    isFromCurrentSender ? MainAxisAlignment.end : MainAxisAlignment.start;

    return Container(
      child: isMessageTopLabelVisible
          ? Row(
        mainAxisAlignment: messageRowMainAxisAlignment,
        children: <Widget>[
          Container(
            padding: messageBottomLabelPadding,
            child: Text(
              message.sender.name,
              style: timeLabelTextStyle,
            ),
          ),
        ],
      )
          : null,
    );
  }

  /// Build Time Label
  Widget _buildTimeLabel({BuildContext context}) {
    final bool isTimeLabelVisible =
        context.read<ChatProvider>().isTimeLabelVisible(index);
    final TextStyle timeLabelTextStyle =
        normalTextStyle(10.H, color: Colors.grey.withOpacity(0.7));

    return Container(
        width: MediaQuery.of(context).size.width,
        child: isTimeLabelVisible
            ? Column(
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
              )
            : null);
  }

  /// Build Message Bottom Row
  Widget _buildMessageBottomRow({BuildContext context}) {
    final bool isMessageBottomLabelVisible =
        context.read<ChatProvider>().isMessageBottomLabelVisible(index);
    final bool isFromCurrentSender =
        context.read<ChatProvider>().isFromCurrentSender(index);
    final MainAxisAlignment messageRowMainAxisAlignment =
        isFromCurrentSender ? MainAxisAlignment.end : MainAxisAlignment.start;
    final EdgeInsets messageBottomLabelPadding = isFromCurrentSender
        ? EdgeInsets.only(
            top: 5.H,
            right: messageStyle.outgoingAvatarWidth +
                messageStyle.outgoingAvatarMargin.horizontal)
        : EdgeInsets.only(
            top: 5.H,
            left: messageStyle.incomingAvatarWidth +
                messageStyle.incomingAvatarMargin.horizontal);
    final TextStyle timeLabelTextStyle =
        normalTextStyle(10.H, color: Colors.grey.withOpacity(0.7));

    return Container(
      child: isMessageBottomLabelVisible
          ? Row(
              mainAxisAlignment: messageRowMainAxisAlignment,
              children: <Widget>[
                Container(
                  padding: messageBottomLabelPadding,
                  child: Text(
                    message.isRead ? 'Seen' : 'Received',
                    style: timeLabelTextStyle,
                  ),
                ),
              ],
            )
          : null,
    );
  }

  /// Build Incoming Message Accessory View
  /// Position: Right of message
  Widget _buildIncomingMessageAccessoryView({BuildContext context}) {
    final bool isMessageAccessoryViewVisible =
        !context.read<ChatProvider>().isNextMessageSameSender(index);
    final TextStyle timeLabelTextStyle =
        normalTextStyle(10.H, color: Colors.grey.withOpacity(0.7));

    return Row(
      children: <Widget>[
        Container(
          padding: isMessageAccessoryViewVisible
              ? EdgeInsets.only(left: 4.W)
              : EdgeInsets.zero,
          child: isMessageAccessoryViewVisible
              ? Text(
                  message.time,
                  style: timeLabelTextStyle,
                )
              : null,
        ),
      ],
    );
  }

  /// Build Incoming Message Avatar View
  Widget _buildIncomingMessageAvatarView({BuildContext context}) {
    final bool isAvatarVisible =
        context.read<ChatProvider>().isAvatarVisible(index);

    return Container(
        margin: messageStyle.incomingAvatarMargin,
        width: messageStyle.incomingAvatarWidth,
        height: messageStyle.incomingAvatarWidth,
        child: isAvatarVisible
            ? CircleAvatar(
                backgroundImage: AssetImage(message.sender.avatar),
                radius: messageStyle.incomingAvatarWidth / 2)
            : null);
  }

  /// Build Outgoing Message Avatar View
  Widget _buildOutgoingMessageAvatarView({BuildContext context}) {
    final bool isAvatarVisible =
        context.read<ChatProvider>().isAvatarVisible(index);

    return Container(
        margin: messageStyle.outgoingAvatarMargin,
        width: messageStyle.outgoingAvatarWidth,
        height: messageStyle.outgoingAvatarWidth,
        child: isAvatarVisible
            ? CircleAvatar(
                backgroundImage: AssetImage(context.read<ChatProvider>().receiver.avatar),
                radius: messageStyle.outgoingAvatarWidth / 2)
            : null);
  }

  /// Build Outgoing Message Accessory View
  Widget _buildOutgoingMessageAccessoryView({BuildContext context}) {
    final bool isMessageAccessoryViewVisible =
        !context.read<ChatProvider>().isNextMessageSameSender(index);
    final TextStyle timeLabelTextStyle =
        normalTextStyle(10.H, color: Colors.grey.withOpacity(0.7));

    return Row(
      children: <Widget>[
        Container(
          padding: isMessageAccessoryViewVisible
              ? EdgeInsets.only(right: 4.W)
              : EdgeInsets.zero,
          child: isMessageAccessoryViewVisible
              ? Text(
                  message.time,
                  style: timeLabelTextStyle,
                )
              : null,
        ),
      ],
    );
  }
}
