import 'package:crocurry/views/bloc/screen/screen_event.dart';
import 'package:crocurry/views/bloc/screen/screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(ScreenState()) {
    on(updateSelectedIndex);
    on(updateSearch);
  }

  Future<void> updateSelectedIndex(
      UpdateScreenIndex event, Emitter<ScreenState> emit) async {
    emit(state.copyWith(index: event.index));
  }

    Future<void> updateSearch(
      UpdateSearchMode event, Emitter<ScreenState> emit) async {
    emit(state.copyWith(search: event.status));
  }
}
