import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/models/local/user.dart';

class ChatProvider with ChangeNotifier {
  // Recipient
  User _receiver;

  // Sender
  User _currentSender;

  // Message list
  final List<MessageBase> _messageList = messages;
  // Text message
  String _messageText;
  // Flag to check if message is valid
  bool _messageValid = false;
  // Flag to check can scroll to bottom or not
  bool _canScrollToBottom = false;

  User get receiver => _receiver;

  set receiver(User value) {
    if (value != _receiver) {
      _receiver = value;
    }
  }

  User get currentSender => _currentSender;

  set currentSender(User value) {
    if (value != _currentSender) {
      _currentSender = value;
    }
  }

  String get messageText => _messageText;

  set messageText(String value) {
    if (value != _messageText) {
      _messageText = value;
      notifyListeners();
    }
  }

  bool get messageValid => _messageValid;

  set messageValid(bool value) {
    if (value != _messageValid) {
      _messageValid = value;
      notifyListeners();
    }
  }

  bool get canScrollToBottom => _canScrollToBottom;

  set canScrollToBottom(bool value) {
    if (value != _canScrollToBottom) {
      _canScrollToBottom = value;
      notifyListeners();
    }
  }

  List<MessageBase> get messageList => _messageList;

  void insertNewMessage(MessageBase message) {
    _messageList.insert(0, message);
    notifyListeners();
  }

  void onSendMessageSuccess() {
    Timer(const Duration(milliseconds: 100), () {
      _messageText = '';
      _messageValid = false;
      _canScrollToBottom = false;
      notifyListeners();
    });
  }

  void onMessageTextChangeToValidateMessage(final String message) {
    _messageText = message;
    _messageValid = message.isNotEmpty;
    notifyListeners();
  }

  void sendMessage() {
    final DateTime currentTime = DateTime.now();
    final String currentTimeString = DateFormat('HH:mm a').format(currentTime);
    final MessageBase newMessage = MessageBase(
      sender: currentUser,
      time: currentTimeString,
      isRead: false,
      text: _messageText,
    );
    _messageList.insert(0, newMessage);
    _canScrollToBottom = true;
    notifyListeners();
  }

  // Because ListView is reversed
  // So previous message is index + 1
  MessageBase getPreviousMessage(int index) {
    if (index + 1 < _messageList.length) {
      return _messageList[index + 1];
    } else {
      return null;
    }
  }

  // Because ListView is reversed
  // So next message is index - 1
  MessageBase getNextMessage(int index) {
    if (index - 1 >= 0) {
      return _messageList[index - 1];
    } else {
      return null;
    }
  }

  MessageBase getMessage(int index) {
    if (index <= _messageList.length) {
      return _messageList[index];
    } else {
      return null;
    }
  }

  bool isNextMessageSameSender(int index) {
    final MessageBase message = getMessage(index);
    final MessageBase nextMessage = getNextMessage(index);

    if (message != null && nextMessage != null) {
      return nextMessage is! ReminderMessage &&
          message is! ReminderMessage &&
          nextMessage.sender.id == _messageList[index].sender.id;
    } else {
      return false;
    }
  }

  bool isPreviousMessageSameSender(int index) {
    final MessageBase message = getMessage(index);
    final MessageBase prevMessage = getPreviousMessage(index);

    if (message != null && prevMessage != null) {
      return prevMessage is! ReminderMessage &&
          message is! ReminderMessage &&
          prevMessage.sender.id == _messageList[index].sender.id;
    } else {
      return false;
    }
  }

  bool isFromCurrentSender(int index) {
    final MessageBase message = getMessage(index);
    if (message != null) {
      return _currentSender.id == message.sender.id;
    } else {
      return false;
    }
  }

  bool isAvatarVisible(int index) {
    final MessageBase message = getMessage(index);

    if (message != null) {
      if (message is ReminderMessage) {
        return false;
      }

      if (isFromCurrentSender(index)) {
        // if (message.isRead == false) {
        //   return true;
        // } else {
        //   // Only show avatar view for latest seen message
        //   final int lastSeenIndex = lastMessageSeenIndexOfCurrentSender();
        //   final int latestMsgIndex = latestMessageIndexOfCurrentSender();
        //
        //   if (lastSeenIndex != null) {
        //     if (latestMsgIndex != null) {
        //       if (index >= lastSeenIndex && index <= latestMsgIndex) {
        //         return true;
        //       }
        //     }
        //   } else {
        //     if (latestMsgIndex != null) {
        //       if (message.isRead == true) {
        //         return index == latestMsgIndex;
        //       }
        //       if (index <= latestMsgIndex) {
        //         return true;
        //       }
        //     }
        //   }
        //
        //   return false;
        // }
        return false;
      } else {
        return !isNextMessageSameSender(index);
      }
    }
  }

  bool isTimeLabelVisible(int index) {
    if (isFromCurrentSender(index)) {
      return false;
    } else {
      return false;
    }
  }

  bool isMessageTopLabelVisible(int index) {
    // final MessageBase message = getMessage(index);
    //
    // if (message != null) {
    //   if (message is ReminderMessage) {
    //     return false;
    //   }
    //   return !isFromCurrentSender(index) && !isPreviousMessageSameSender(index);
    // }

    return false;
  }

  bool isMessageBottomLabelVisible(int index) {
    // final MessageBase message = getMessage(index);
    //
    // if (message != null) {
    //   if (message is ReminderMessage) {
    //     return false;
    //   }
    //   return isFromCurrentSender(index) && !isNextMessageSameSender(index);
    // }
    return false;
  }

  bool isMessageAccessoryViewVisible(int index) {
    final MessageBase message = getMessage(index);

    if (message != null) {
      if (message is ReminderMessage) {
        return false;
      }
      return !isNextMessageSameSender(index);
    }
  }

  int latestMessageIndexOfCurrentSender() {
    // // Wrong
    // final List<MessageBase> messagesOfCurrentUser = _messageList
    //     .where((MessageBase msg) => msg.sender.id == _currentSender.id)
    //     .toList();
    //
    // return _messageList.lastIndexOf(messagesOfCurrentUser.first);

    // int latestIndex;
    // _messageList.reversed.toList().asMap().forEach((int index, MessageBase message) {
    //   int section = index + 1;
    //   while (section < _messageList.length) {
    //     if (isFromCurrentSender(section)) {
    //       latestIndex = section;
    //     }
    //     section += 1;
    //   }
    // });
    // return latestIndex;

    final int count = _messageList.reversed.toList().length;
    if (count >= 1) {
      int section = count - 1;
      while (section > -1) {
        if (isFromCurrentSender(section)) {
          return section;
        }
        section -= 1;
      }
    }
  }

  int lastMessageSeenIndexOfCurrentSender() {
    final int latestIndex = latestMessageIndexOfCurrentSender();

    if (latestIndex != null && latestIndex > 0 && latestIndex - 1 > 0) {
      int section = latestIndex - 1;
      while (section > -1) {
        final MessageBase message = getMessage(section);
        if (message != null &&
            isFromCurrentSender(section) &&
            message.isRead == true) {
          return section;
        }
        section -= 1;
      }
    }
  }
}
