import 'package:crocurry/domain/use_cases/auth/check_logged_in.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:crocurry/views/bloc/app_details/app_details_bloc.dart';
import 'package:crocurry/views/bloc/app_details/app_details_event.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(FetchUserDetailsFromShared());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        initVersionDetails();
        checkAndNavigate(context);
      }
    });
    super.initState();
  }

  initVersionDetails() async {
    context.read<AppDetailsBloc>().add(InitAppDetailsEvent());
  }

  checkAndNavigate(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Helper.pushReplacement(homeScreenRoute);

      /// checks whether user is logged in form shared-prefs
      // if (await locator<CheckLoggedIn>().call()) {
      //   if (context.mounted) {
      //     /// fetches user-details from shared-prefs and adds
      //     /// to bloc state for easy ui updates
      //     context.read<UserBloc>().add(FetchUserDetailsFromShared());
      //     CustomToast.showSuccessMessage(
      //         context: context, message: 'Login Success!');
      //     Navigator.pushNamed(context, homeScreenRoute);
      //   }
      // } else {
      //   if (context.mounted) {
      //     Navigator.pushNamed(context, onbordingScreenRoute);
      //   }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
          child: Image.asset(
        'assets/logo/app_logo.png',
        width: Helper.getWidth(context) / 1.5,
      )),
    );
  }
}
