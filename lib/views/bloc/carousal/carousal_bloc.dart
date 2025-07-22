import 'package:crocurry/domain/use_cases/product/get_carousal.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/carousal/carousal_event.dart';
import 'package:crocurry/views/bloc/carousal/carousal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarousalBloc extends Bloc<CarousalEvent, CarousalState> {
  CarousalBloc() : super(CarousalState()) {
    on(getCarousal);
    on(setIndex);
    on(incrementIndex);
  }

  Future<void> getCarousal(
      FetchCarousal event, Emitter<CarousalState> emit) async {
    emit(state.copyWith(loading: true));

    final details = await locator<GetCarousal>().call();
    emit(state.copyWith(loading: false, items: details.$1 ?? []));
  }

  Future<void> setIndex(UpdateIndex event, Emitter<CarousalState> emit) async {
    emit(state.copyWith(index: event.index));
  }

  Future<void> incrementIndex(
      IncrementIndex event, Emitter<CarousalState> emit) async {
    emit(state.copyWith(index: state.currentIndex + 1));
  }
}
