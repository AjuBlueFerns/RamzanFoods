
import 'package:crocurry/views/bloc/carousal/carousal_bloc.dart';
import 'package:crocurry/views/bloc/carousal/carousal_event.dart';
import 'package:crocurry/views/bloc/carousal/carousal_state.dart';
import 'package:crocurry/views/screens/home/views/components/carousal/carousal_pageview.dart';
import 'package:crocurry/views/screens/home/views/components/carousal/carousal_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:crocurry/views/screens/components/dot_indicators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants.dart';

class CarouselSection extends StatefulWidget {
  const CarouselSection({
    super.key,
  });

  @override
  State<CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<CarouselSection> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CarousalBloc>().add(FetchCarousal());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          BlocBuilder<CarousalBloc, CarousalState>(builder: (context, state) {
            return state.isLoading
                ? const CarousalSkeleton()
                : const CarousalPageview();
          }),
          BlocBuilder<CarousalBloc, CarousalState>(builder: (context, state) {
            return state.isLoading
                ? const SizedBox.shrink()
                : FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding)+ const EdgeInsets.only(bottom: 0),
                      child: SizedBox(
                        height: 16,
                        child: Row(
                          children: List.generate(
                            state.carousel.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: defaultPadding / 4),
                                child: DotIndicator(
                                  isActive: index == state.currentIndex,
                                  activeColor: Colors.white70,
                                  inActiveColor: Colors.white54,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
