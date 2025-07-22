import 'package:crocurry/views/bloc/app_details/app_details_event.dart';
import 'package:crocurry/views/bloc/app_details/app_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDetailsBloc extends Bloc<AppDetailsEvent, AppDetailsState> {
  AppDetailsBloc() : super(AppDetailsState()) {
    on(initDetails);
  }

  Future initDetails(
      InitAppDetailsEvent event, Emitter<AppDetailsState> emit) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    emit(state.copyWith(version: version, build: buildNumber));
  }
}
