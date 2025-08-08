import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/screens/components/loading_shimmer.dart';
import 'package:crocurry/views/screens/components/skleton/skelton.dart';
import 'package:flutter/material.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class ImageFullScreen extends StatelessWidget {
  const ImageFullScreen({super.key, required this.fit, required this.src});
  final BoxFit fit;
  final String src;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor40,
      body: Center(
        child: SizedBox(
          width: context.screenWidth,
          child: ZoomOverlay(
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              imageUrl: src,
              cacheKey: src,
              // progressIndicatorBuilder: (context, url, progress) {
                
              // },
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    // fit: fitWidth,
                  ),
                ),
              ),
              placeholder: (context, url) => const LoadingShimmer(child: Skeleton()),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }
}