import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyColor.withOpacity(0.5),
      highlightColor: greyColor,
      child: child,
    );
  }

  factory LoadingShimmer.rectangle({
    required double height,
    required double width,
    double? borderRadius,
  }) {
    return LoadingShimmer(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: BorderRadius.circular(
            borderRadius ?? 0,
          ),
        ),
      ),
    );
  }

  factory LoadingShimmer.circle({
    required double size,
    required BuildContext context,
  }) {
    return LoadingShimmer(
      child: CircleAvatar(
        radius: size,
        backgroundColor: context.primaryColor,
      ),
    );
  }
}
