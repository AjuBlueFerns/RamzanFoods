import 'package:crocurry/domain/use_cases/product/get_carousal.dart';
import 'package:crocurry/views/bloc/carousal/carousal_bloc.dart';
import 'package:crocurry/views/bloc/carousal/carousal_event.dart';
import 'package:crocurry/views/screens/components/skleton/skelton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../utils/constants.dart';

class CarousalSkeleton extends StatelessWidget {
  const CarousalSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.87,
      child: Stack(
        children: [
          const Skeleton(),
          const Positioned.fill(
            left: defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(
                  width: 140,
                  height: 20,
                ),
                SizedBox(height: defaultPadding / 2),
                Skeleton(
                  width: 200,
                  height: 20,
                ),
              ],
            ),
          ),
          Positioned(
            right: defaultPadding,
            bottom: defaultPadding,
            child: Row(
              children: List.generate(
                4,
                (index) => const Padding(
                  padding: EdgeInsets.only(left: defaultPadding / 4),
                  child: CircleSkeleton(size: 8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
