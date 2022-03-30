import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/models/local/message.dart';
import 'package:nft/pages/chat_ui/chat/message_style.dart';
import 'package:nft/pages/chat_ui/image_detail/image_detail_page.dart';
import 'package:nft/pages/chat_ui/image_detail/image_detail_provider.dart';
import 'package:nft/pages/chat_ui/widgets/w_message_container.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_route.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../services/app/dynamic_size.dart';

class WImagesMessage extends StatelessWidget with DynamicSize {
  const WImagesMessage({Key key, this.message, this.index, this.messageStyle})
      : super(key: key);

  final ImageMessage message;
  final int index;
  final MessageStyle messageStyle;

  @override
  Widget build(BuildContext context) {
    return WMessageContainer(
      message: message,
      index: index,
      messageStyle: messageStyle,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        child: Container(
            constraints: BoxConstraints(
              maxHeight: getImagesContainerHeight(message.images),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: message.images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getCrossAxisCount(message.images.length),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    final List<String> imageUrls = message.images
                        .map((ImageObject image) => image.url)
                        .toList();
                    context.read<ImageDetailProvider>().currentImgUrl =
                        message.images[index].url;
                    context.read<ImageDetailProvider>().imageUrls = imageUrls;
                    // context.navigator().pushNamed(AppRoute.routeImageDetail);
                    openBottomSheet(context, message.images[index].url);
                    // context.navigator().pushNamed(AppRoute.routeSlidePage);
                  },
                  child: Hero(
                    tag: message.images[index].url,
                    child: CachedNetworkImage(
                      imageUrl: message.images[index].url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  double getImagesContainerHeight(List<ImageObject> images) {
    final double landscapeWidth = messageStyle.messageContainerMaxWidth;
    final double landscapeHeight = 188.H;
    if (images.length == 1) {
      if (images[0].width > images[0].height) {
        return landscapeHeight;
      } else {
        return landscapeWidth;
      }
    } else if (images.length == 2) {
      return 160.H;
    } else {
      return (94.H * (images.length / 2.0)).floorToDouble();
    }
  }

  int getCrossAxisCount(int imagesCount) {
    if (imagesCount >= 3) {
      return 3;
    } else {
      return imagesCount;
    }
  }

  void openBottomSheet(BuildContext context, String url) => showBottomSheet<dynamic>(
    context: context,
    backgroundColor: Colors.transparent,
    shape: const ContinuousRectangleBorder(),
    builder: (BuildContext context) {
      return PhotoViewGestureDetectorScope(
        axis: Axis.vertical,
        child: const ImageDetailPage()
      );
    },
  );
}