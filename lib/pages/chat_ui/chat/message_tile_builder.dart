// import 'package:nft/models/local/message.dart';
// import 'package:flutter/material.dart';
// import 'package:nft/models/local/user.dart';
// import 'package:nft/services/app/dynamic_size.dart';
// import 'package:nft/utils/app_extension.dart';
// import 'package:nft/utils/app_style.dart';
//
// import 'builders.dart';
// import 'functional_widget_annotation.dart';
// import 'message_style.dart';
//
// class MessageTileBuilders<T extends Message> {
//   final Widget Function(BuildContext context, Animation<double> animation,
//       int index, T item) customTileBuilder;
//
//   /// Call this builder to override the default [DateLabel] widget to build the date labels
//   final DateBuilder customDateBuilder;
//
//   /// Wraps the default [MessagesListTile] and overrides the default [InkWell]
//   /// If you use this, you have to implement your own selection Widget
//   final Widget Function(BuildContext context, int index, T item, Widget child) wrapperBuilder;
//
//   const MessageTileBuilders(
//       {this.customTileBuilder,
//         this.customDateBuilder,
//         this.wrapperBuilder,
//         this.incomingMessageBuilders = const IncomingMessageTileBuilders(),
//         this.outgoingMessageBuilders = const OutgoingMessageTileBuilders()});
//
//   final IncomingMessageTileBuilders incomingMessageBuilders;
//
//   final OutgoingMessageTileBuilders outgoingMessageBuilders;
// }
//
// class IncomingMessageTileBuilders<T extends Message> {
//   const IncomingMessageTileBuilders(
//       {this.avatarBuilder,
//         this.bodyBuilder,
//         this.titleBuilder});
//
//   /// Builder to display a widget in front of the body;
//   /// Typically build the user's avatar here
//   final MessageWidgetBuilder avatarBuilder;
//
//   /// Builder to display a widget on top of the first message from the same user.
//   /// Typically build the user's username here.
//   /// Pass null to disable the default builder [_defaultIncomingMessageTileTitleBuilder].
//   final MessageWidgetBuilder titleBuilder;
//
//   /// Override the default text widget and supply a complete widget (including container) using your own logic
//   final MessageWidgetBuilder bodyBuilder;
// }
//
// class OutgoingMessageTileBuilders<T extends Message> {
//   /// Override the default text widget and supply a complete widget (including container) using your own logic
//   const OutgoingMessageTileBuilders({this.bodyBuilder});
//
//   final MessageWidgetBuilder bodyBuilder;
// }
//
// class MessagesListTile<T extends Message> extends StatelessWidget {
//   const MessagesListTile(
//       {Key key,
//         this.item,
//         this.index,
//         // required this.controller,
//         this.currentSender,
//         this.style,
//         this.builders})
//       : super(key: key);
//
//   /// The item containing the tile data
//   final T item;
//
//   /// The list index of this tile
//   final int index;
//
//   /// The controller that manages items and actions
//   // final MessagesListController controller;
//
//   /// The id of the app's current user.
//   /// Required to determine whether a message is owned
//   final User currentSender;
//
//   final MessageStyle style;
//
//   final MessageTileBuilders<T> builders;
//
//   @override
//   Widget build(BuildContext context) {
//     final Widget child = Padding(
//         padding: style!.padding,
//         child: _messageFlow == MessageFlow.outgoing
//             ? OutgoingMessage(
//             item: item,
//             index: index,
//             messagePosition: messagePosition,
//             builders: builders!.outgoingMessageBuilders)
//             : IncomingMessage(
//             item: item,
//             index: index,
//             style: style,
//             messagePosition: messagePosition,
//             builders: builders!.incomingMessageBuilders));
//     if (builders!.wrapperBuilder != null)
//       return builders!.wrapperBuilder!
//           .call(context, index, item, messagePosition, child);
//     return Container(
//         foregroundDecoration: BoxDecoration(
//             color: controller.isItemSelected(item)
//                 ? style!.selectionColor ?? Colors.white.withAlpha(50)
//                 : Colors.transparent),
//         child: Material(
//             clipBehavior: Clip.antiAlias,
//             type: MaterialType.transparency,
//             child: InkWell(
//                 onTap: () => controller.onItemTap(context, index, item),
//                 onLongPress: () =>
//                     controller.onItemLongPress(context, index, item),
//                 child: AbsorbPointer(
//                     absorbing: controller.isSelectionModeActive,
//                     child: child))));
//   }
// }
//
// @swidget
// Widget messageFooter<T extends Message, DynamicSize>(BuildContext context, T item) {
//   return Padding(
//       padding: EdgeInsets.only(left: 8.W),
//       child: Text(
//           item.time,
//           style: normalTextStyle(10.H, color: Colors.grey.withOpacity(0.7))));
// }