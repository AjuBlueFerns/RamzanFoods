import 'dart:async';

import 'package:crocurry/views/bloc/carousal/carousal_bloc.dart';
import 'package:crocurry/views/bloc/carousal/carousal_event.dart';
import 'package:crocurry/views/bloc/carousal/carousal_state.dart';
import 'package:crocurry/views/screens/home/views/components/carousal/carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarousalPageview extends StatefulWidget {
  const CarousalPageview({super.key});

  @override
  State<CarousalPageview> createState() => _CarousalPageviewState();
}

class _CarousalPageviewState extends State<CarousalPageview> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (context.read<CarousalBloc>().state.currentIndex <
          context.read<CarousalBloc>().state.carousel.length - 1) {
        _pageController.animateToPage(
          context.read<CarousalBloc>().state.currentIndex + 1,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        );
        context.read<CarousalBloc>().add(IncrementIndex());
      } else {
        _pageController.jumpTo(0);
        context.read<CarousalBloc>().add(UpdateIndex(index: 0));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarousalBloc, CarousalState>(builder: (context, state) {
      return PageView.builder(
        controller: _pageController,
        allowImplicitScrolling: true,
        itemCount: state.carousel.length,
        onPageChanged: (int index) {
          context.read<CarousalBloc>().add(UpdateIndex(index: index));
        },
        itemBuilder: (context, index) {
          var item = state.carousel[index];
          return CarouselItem(
            press: () {},
            carousal: item,
          );
        },
      );
    });
  }
}
