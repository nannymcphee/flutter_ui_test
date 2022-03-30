import 'package:flutter/foundation.dart';
import 'package:nft/models/local/user.dart';

enum MessageType { text, images, reminder }

enum MessageStatus {
  sent,
  received,
  seen,
}

enum ReminderRepeatType {
  none,
  daily,
  weekly,
  monthly,
  yearly,
}

class MessageBase {
  MessageBase({
    @required this.id,
    @required this.sender,
    @required this.avatar,
    @required this.time,
    @required this.unreadCount,
    @required this.text,
    @required this.type,
    @required this.isRead,
  });

  final int id;
  final User sender;
  final String avatar;
  final String time;
  final int unreadCount;
  final bool isRead;
  final String text;
  final int type;
}

class ReminderObject {
  ReminderObject({this.time, this.repeatType, this.isEnded, this.title});

  final String time;
  final ReminderRepeatType repeatType;
  final bool isEnded;
  final String title;
}

class ReminderMessage extends MessageBase {
  ReminderMessage(
      {int id,
      User sender,
      String avatar,
      String time,
      int unreadCount,
      String text,
      int type,
      bool isRead,
      this.reminder})
      : super(
            id: id,
            sender: sender,
            avatar: avatar,
            time: time,
            unreadCount: unreadCount,
            text: text,
            type: type,
            isRead: isRead);
  final ReminderObject reminder;
}

class ImageObject {
  ImageObject({this.url, this.width, this.height});
  final String url;
  final double width;
  final double height;
}

class ImageMessage extends MessageBase {
  ImageMessage(
      {int id,
      User sender,
      String avatar,
      String time,
      int unreadCount,
      String text,
      int type,
      bool isRead,
      this.images})
      : super(
            id: id,
            sender: sender,
            avatar: avatar,
            time: time,
            unreadCount: unreadCount,
            text: text,
            type: type,
            isRead: isRead);
  final List<ImageObject> images;
}

final List<MessageBase> recentChats = <MessageBase>[
  MessageBase(
      id: 0,
      sender: addison,
      avatar: 'assets/app/icons/Addison.jpg',
      time: '01:25',
      text: 'typing...',
      unreadCount: 1,
      isRead: false),
  MessageBase(
      id: 1,
      sender: jason,
      avatar: 'assets/app/icons/Jason.jpg',
      time: '12:46',
      text: 'Will I be in it?',
      unreadCount: 1,
      isRead: false),
  MessageBase(
      id: 2,
      sender: deanna,
      avatar: 'assets/app/icons/Deanna.jpg',
      time: '05:26',
      text: "That's so cute.",
      unreadCount: 3,
      isRead: false),
  MessageBase(
      id: 3,
      sender: nathan,
      avatar: 'assets/app/icons/Nathan.jpg',
      time: '12:45',
      text: 'Let me see what I can do.',
      unreadCount: 2,
      isRead: false),
];

final List<MessageBase> allChats = <MessageBase>[
  MessageBase(
      id: 4,
      sender: addison,
      avatar: 'assets/app/icons/Addison.jpg',
      time: '01:25',
      text: 'typing...',
      unreadCount: 1,
      isRead: false),
  MessageBase(
      id: 5,
      sender: jason,
      avatar: 'assets/app/icons/Jason.jpg',
      time: '12:46',
      text: 'Will I be in it?',
      unreadCount: 1,
      isRead: false),
  MessageBase(
      id: 6,
      sender: deanna,
      avatar: 'assets/app/icons/Deanna.jpg',
      time: '05:26',
      text: "That's so cute.",
      unreadCount: 3,
      isRead: true),
  MessageBase(
    id: 7,
    sender: nathan,
    avatar: 'assets/app/icons/Nathan.jpg',
    time: '12:45',
    text: 'Let me see what I can do.',
    unreadCount: 2,
    isRead: true,
  ),
  MessageBase(
    id: 8,
    sender: virgil,
    avatar: 'assets/app/icons/Virgil.jpg',
    time: '12:59',
    text: 'No! I just wanted',
    unreadCount: 0,
    isRead: true,
  ),
  MessageBase(
    id: 9,
    sender: stanley,
    avatar: 'assets/app/icons/Stanley.jpg',
    time: '10:41',
    text: 'You did what?',
    unreadCount: 1,
    isRead: false,
  ),
  MessageBase(
    id: 10,
    sender: leslie,
    avatar: 'assets/app/icons/Leslie.jpg',
    time: '05:51',
    unreadCount: 0,
    isRead: true,
    text: 'just signed up for a tutor',
  ),
  MessageBase(
    id: 11,
    sender: judd,
    avatar: 'assets/app/icons/Judd.jpg',
    time: '10:16',
    text: 'May I ask you something?',
    unreadCount: 2,
    isRead: false,
  ),
];

final List<MessageBase> messages = <MessageBase>[
  ImageMessage(
      id: 12, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=1', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=2', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=3', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=4', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=5', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=6', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=7', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=8', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=9', width: 3000, height: 1000),
  ]),
  ImageMessage(
      id: 13, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=10', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=11', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=12', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=13', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=14', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=15', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=16', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=17', width: 3000, height: 1000),
  ]),
  ImageMessage(
      id: 14, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=18', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=19', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=20', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=21', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=22', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=23', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=24', width: 3000, height: 1000),
  ]),
  ImageMessage(
      id: 15, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=25', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=26', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=27', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=28', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=29', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=30', width: 3000, height: 1000),
  ]),
  ImageMessage(
      id: 16, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=31', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=32', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=33', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=34', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=35', width: 3000, height: 1000),
  ]),
  ImageMessage(
      id: 17, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=36', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=37', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=38', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=39', width: 3000, height: 1000),
  ]),
  ImageMessage(
      id: 18, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=40', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=41', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=42', width: 3000, height: 1000),
  ]),
  ImageMessage(
      id: 19, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=43', width: 3000, height: 1000),
    ImageObject(
        url: 'https://picsum.photos/250?image=44', width: 3000, height: 1000),
  ]),
  ImageMessage(
      id: 20, sender: addison, avatar: addison.avatar, time: '16:00 PM', unreadCount: 0, text: '', type: 2, isRead: true, images: <ImageObject>[
    ImageObject(
        url: 'https://picsum.photos/250?image=45', width: 3000, height: 1000)
  ]),
  ReminderMessage(
      id: 21,
      sender: addison,
      avatar: addison.avatar,
      time: '16:00 PM',
      unreadCount: 0,
      text: '',
      type: 2,
      isRead: true,
      reminder: ReminderObject(
          title: 'Test reminder',
          time: 'Thứ 2, 5 tháng 3 lúc 16:00',
          repeatType: ReminderRepeatType.none,
          isEnded: true)),
  ReminderMessage(
      id: 22,
      sender: addison,
      avatar: addison.avatar,
      time: '16:00 PM',
      unreadCount: 0,
      text: '',
      type: 2,
      isRead: true,
      reminder: ReminderObject(
          title: 'Test reminder',
          time: 'Thứ 2, 5 tháng 3 lúc 16:00',
          repeatType: ReminderRepeatType.none,
          isEnded: false)),
  MessageBase(
    sender: addison,
    time: '12:09 AM',
    avatar: addison.avatar,
    text: 'Hello',
    isRead: false,
  ),
  MessageBase(
    sender: addison,
    time: '12:09 AM',
    avatar: addison.avatar,
    text: 'Hey',
    isRead: false,
  ),
  MessageBase(
    sender: addison,
    time: '12:09 AM',
    avatar: addison.avatar,
    text: 'Are you ok?',
    isRead: false,
  ),
  MessageBase(
    sender: addison,
    time: '12:10 AM',
    avatar: addison.avatar,
    text: 'Why are you not in the office?',
    isRead: false,
  ),
  MessageBase(
    sender: addison,
    time: '12:10 AM',
    avatar: addison.avatar,
    text: 'I have something to discuss with you',
    isRead: false,
  ),
  MessageBase(
    sender: addison,
    time: '12:11 AM',
    avatar: addison.avatar,
    text: 'Hellooooooooo',
    isRead: false,
  ),
  MessageBase(
    sender: currentUser,
    time: '12:05 AM',
    isRead: true,
    text: 'I’m going home.',
  ),
  MessageBase(
    sender: currentUser,
    time: '12:05 AM',
    isRead: true,
    text: 'See, I was right, this doesn\'t interest me.',
  ),
  MessageBase(
    sender: addison,
    time: '11:58 PM',
    avatar: addison.avatar,
    text: 'I sign your paychecks.',
    isRead: true,
  ),
  MessageBase(
    sender: addison,
    time: '11:58 PM',
    avatar: addison.avatar,
    text: 'You think we have nothing to talk about?',
    isRead: true,
  ),
  MessageBase(
    sender: currentUser,
    time: '11:45 PM',
    isRead: true,
    text:
        'Well, because I had no intention of being in your office. 20 minutes ago',
  ),
  MessageBase(
    sender: addison,
    time: '11:30 PM',
    avatar: addison.avatar,
    text: 'I was expecting you in my office 20 minutes ago.',
    isRead: true,
  ),
];
