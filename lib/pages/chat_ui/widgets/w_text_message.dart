import 'package:flutter/material.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/pages/chat_ui/chat/message_style.dart';
import 'package:nft/pages/chat_ui/widgets/w_message_container.dart';
import 'package:nft/utils/app_extension.dart';

import '../../../services/app/dynamic_size.dart';

class WTextMessage extends StatelessWidget with DynamicSize {
  const WTextMessage({Key key, this.message, this.index, this.messageStyle}) : super(key: key);

  final MessageBase message;
  final int index;
  final MessageStyle messageStyle;

  @override
  Widget build(BuildContext context) {
    return WMessageContainer(
      message: message,
      index: index,
      messageStyle: messageStyle,
      child: Container(
        padding: EdgeInsets.fromLTRB(14.W, 10.H, 14.W, 10.H),
        child: Text(
          message.text,
          style: messageStyle.textMessageStyle,
        ),
      ),
    );
  }
}
