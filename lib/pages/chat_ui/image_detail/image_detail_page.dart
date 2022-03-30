import 'package:flutter/material.dart';
import 'package:nft/pages/chat_ui/image_detail/image_detail_provider.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/widgets/p_material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/app_style.dart';

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage({Key key}) : super(key: key);

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends PageStateful<ImageDetailPage>
    with WidgetsBindingObserver, RouteAware {
  // Provider
  ImageDetailProvider _imageDetailProvider;
  // Page controller
  PageController _pageController;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
  }

  @override
  void afterFirstBuild(BuildContext context) {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _imageDetailProvider = Provider.of(context, listen: false);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRoute.I.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AppRoute.I.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    initDynamicSize(context);

    return Consumer<ImageDetailProvider>(
        builder: (BuildContext context, ImageDetailProvider provider, _) {
          _pageController = PageController(initialPage: provider.currentPageIndex);

      return PMaterial(
        child: Container(
          // color: Colors.black,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                pageController: _pageController,
                enableRotation: true,
                onPageChanged: (int index) {
                  provider.onPageChanged(index);
                },
                itemCount: provider.imageUrls.length,
                backgroundDecoration: BoxDecoration(
                  color: Colors.black.withAlpha(240)
                ),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(provider.imageUrls[index]),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    heroAttributes: PhotoViewHeroAttributes(tag: provider.imageUrls[index]),
                  );
                },
                loadingBuilder: (BuildContext context, ImageChunkEvent event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                    ),
                  ),
                ),
              ),
              Positioned(
                // top: MediaQuery.of(context).padding.top,
                top: 54.H,
                left: 20.W,
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 24.W,
                      color: Colors.white,
                    ),
                    splashRadius: 24.W,
                    color: Colors.white,
                    onPressed: () {
                      context.navigator().pop();
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// class SlidePage extends StatefulWidget {
//   const SlidePage({this.url});
//   final String url;
//   @override
//   _SlidePageState createState() => _SlidePageState();
// }
//
// class _SlidePageState extends State<SlidePage> {
//   GlobalKey<ExtendedImageSlidePageState> slidePagekey =
//   GlobalKey<ExtendedImageSlidePageState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: ExtendedImageSlidePage(
//         key: slidePagekey,
//         child: GestureDetector(
//           child: ExtendedImage.network(
//             widget.url,
//             enableSlideOutPage: true,
//
//             ///make hero better when slide out
//             heroBuilderForSlidingPage: (Widget result) {
//               return Hero(
//                 tag: widget.url,
//                 child: result,
//                 flightShuttleBuilder: (BuildContext flightContext,
//                     Animation<double> animation,
//                     HeroFlightDirection flightDirection,
//                     BuildContext fromHeroContext,
//                     BuildContext toHeroContext) {
//                   final Hero hero =
//                   (flightDirection == HeroFlightDirection.pop
//                       ? fromHeroContext.widget
//                       : toHeroContext.widget) as Hero;
//                   return hero.child;
//                 },
//               );
//             },
//           ),
//           onTap: () {
//             slidePagekey.currentState.popPage();
//             Navigator.pop(context);
//           },
//         ),
//         slideAxis: SlideAxis.both,
//         slideType: SlideType.onlyImage,
//       ),
//     );
//   }
// }