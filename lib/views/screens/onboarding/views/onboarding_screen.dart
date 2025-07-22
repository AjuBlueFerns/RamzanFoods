import 'package:crocurry/domain/use_cases/auth/check_logged_in.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_event.dart';
import 'package:crocurry/views/screens/components/common_btn.dart';
import 'package:crocurry/views/screens/components/dot_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'components/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  final List<Onbord> _onbordData = [
    Onbord(
      image: "assets/onboarding/1.jpg",
      imageDarkTheme: "assets/onboarding/1.jpg",
      title: "World of perfection",
      description: "Organise your space in style",
    ),
    Onbord(
      image: "assets/onboarding/2.png",
      imageDarkTheme: "assets/onboarding/2.png",
      title: "Indulge in Elegence",
      description: "Experience Culinery Art with Every Bite",
    ),
    Onbord(
      image: "assets/onboarding/3.png",
      imageDarkTheme: "assets/onboarding/3.png",
      title: "Gifts are here",
      description:
          "Direct gift sending system, you just need to\nbuy it we deliver it to your loved ones.",
    ),
  ];

  Future navigateToHomeOrLogin(BuildContext context) async {
    if (await locator<CheckLoggedIn>().call()) {
      if (context.mounted) {
        var userBloc = context.read<UserBloc>();
        userBloc.add(FetchUserDetailsFromShared());
        if (userBloc.state.user != null) {
          CustomToast.showSuccessMessage(
              context: context, message: 'Login Success!');
        }

        Navigator.pushNamed(context, homeScreenRoute);
      }
    } else {
      if (context.mounted) {
        // Navigator.pushNamed(context, logInScreenRoute);
        Navigator.pushNamed(context, homeScreenRoute);
      }
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      navigateToHomeOrLogin(context);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onbordData.length,
                    onPageChanged: (value) {
                      setState(() {
                        _pageIndex = value;
                      });
                    },
                    itemBuilder: (context, index) => OnboardingContent(
                      title: _onbordData[index].title,
                      description: _onbordData[index].description,
                      image: (Theme.of(context).brightness == Brightness.dark &&
                              _onbordData[index].imageDarkTheme != null)
                          ? _onbordData[index].imageDarkTheme!
                          : _onbordData[index].image,
                      isTextOnTop: index.isOdd,
                    ),
                  ),
                ),
                Row(
                  children: [
                    ...List.generate(
                      _onbordData.length,
                      (index) => Padding(
                        padding:
                            const EdgeInsets.only(right: defaultPadding / 4),
                        child: DotIndicator(isActive: index == _pageIndex),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CommonBtn(
                        onPressed: () async {
                          if (_pageIndex < _onbordData.length - 1) {
                            _pageController.nextPage(
                                curve: Curves.ease, duration: defaultDuration);
                          } else {
                            navigateToHomeOrLogin(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/Arrow - Right.svg",
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: defaultPadding),
              ],
            )),
      ),
    );
  }
}

class Onbord {
  final String image, title, description;
  final String? imageDarkTheme;

  Onbord({
    required this.image,
    required this.title,
    this.description = "",
    this.imageDarkTheme,
  });
}
