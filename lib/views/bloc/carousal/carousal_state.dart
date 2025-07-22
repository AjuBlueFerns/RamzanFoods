import 'package:crocurry/data/models/carousal_model.dart';

class CarousalState {
  List<CarousalModel> carousel;
  final bool isLoading;
  final int currentIndex;
  CarousalState({
    this.carousel = const [],
    this.currentIndex = 0,
    this.isLoading = true,
  });

  CarousalState copyWith(
      {List<CarousalModel>? items, bool? loading, int? index}) {
    return CarousalState(
      carousel: items ?? carousel,
      isLoading: loading ?? isLoading,
      currentIndex: index ?? currentIndex,
    );
  }
}
