import 'package:flutter/material.dart';

/// Styling and settings for [MessagesList].
class MessageStyle {
  const MessageStyle(
      {this.padding = EdgeInsets.zero,
        this.outgoingAvatarWidth = 0,
        this.incomingAvatarWidth = 30.0,
        this.messageContainerColor,
        this.outgoingAvatarMargin,
        this.incomingAvatarMargin,
        this.textMessageStyle,
        this.messageContainerMaxWidth,
      });

  /// Constrained width for the avatar, when displayed
  /// if an avatarBuilder is supplied but no avatar is built due to positioning,
  /// [avatarWidth] is also used to build an empty container to align all messages
  final double outgoingAvatarWidth;

  final double incomingAvatarWidth;

  final EdgeInsets outgoingAvatarMargin;

  final EdgeInsets incomingAvatarMargin;

  /// The outer padding of each tile
  final EdgeInsets padding;

  /// The color applied to the whole
  final Color messageContainerColor;

  final TextStyle textMessageStyle;

  final double messageContainerMaxWidth;
}