import 'package:flutter/material.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/pages/chat_ui/chat/message_style.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';

import '../../../services/app/dynamic_size.dart';

class WReminderMessage extends StatelessWidget with DynamicSize {
  const WReminderMessage({Key key, this.message, this.index, this.messageStyle}) : super(key: key);

  final ReminderMessage message;
  final int index;
  final MessageStyle messageStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.W),
      width: MediaQuery.of(context).size.width - 40.W,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5.H),
      ),
      child: Padding(
          padding: EdgeInsets.all(15.H),
          child: message.reminder.isEnded
              ? _buildEndedReminderMessageContainer(message)
              : _buildReminderMessageContainer(message)),
    );
  }

  Widget _buildReminderMessageContainer(ReminderMessage message) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 32.W,
                height: 32.H,
                child: CircleAvatar(
                    backgroundImage: AssetImage(message.sender.avatar),
                    radius: messageStyle.outgoingAvatarWidth / 2),
              ),
              SizedBox(width: 15.W),
              Flexible(
                child: Text(
                  '${message.sender.name} tạo một nhắc hẹn',
                  style: normalTextStyle(14.H, color: Colors.white),
                ),
              )
            ],
          ),
        ),

        /// Separator
        Container(
          margin: EdgeInsets.symmetric(vertical: 15.H),
          height: 1.0,
          color: Colors.grey.withOpacity(0.7),
        ),
        Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'THG 4',
                  style: normalTextStyle(14.H, color: Colors.redAccent),
                ),
                SizedBox(height: 4.H),
                Text(
                  '05',
                  style: normalTextStyle(16.H, color: Colors.white),
                )
              ],
            ),
            SizedBox(width: 20.W),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message.reminder.title,
                    style: semiBoldTextStyle(14.H, color: Colors.white),
                  ),
                  SizedBox(height: 4.H),
                  Text(
                    message.reminder.time,
                    style: normalTextStyle(14.H, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),

        /// Separator
        Container(
          margin: EdgeInsets.symmetric(vertical: 15.H),
          height: 1.0,
          color: Colors.grey.withOpacity(0.7),
        ),
        Text(
          'Cả hai sẽ được thông báo vào thời điểm đã chọn',
          style: normalTextStyle(12.H, color: Colors.grey.withOpacity(0.7)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _buildEndedReminderMessageContainer(ReminderMessage message) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.notifications_active_rounded,
          color: Colors.white,
          size: 32.H,
        ),
        SizedBox(height: 10.H),
        Text(
          'Nhắc hẹn: ${message.reminder.title}',
          style: semiBoldTextStyle(15.H, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.H),
        Text(
          message.reminder.time,
          style: normalTextStyle(13.H, color: Colors.white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
