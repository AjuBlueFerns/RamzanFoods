import 'package:animations/animations.dart';
import 'package:crocurry/domain/use_cases/auth/check_logged_in.dart';
import 'package:crocurry/domain/use_cases/connectivity/check_connectivity_repo.dart';
import 'package:crocurry/domain/use_cases/product/get_categories.dart';
import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/utils/route/screen_export.dart';
import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
import 'package:crocurry/views/bloc/auth/auth_event.dart';
import 'package:crocurry/views/bloc/carousal/carousal_bloc.dart';
import 'package:crocurry/views/bloc/carousal/carousal_event.dart';
import 'package:crocurry/views/bloc/cart/cart_bloc.dart';
import 'package:crocurry/views/bloc/cart/cart_event.dart';
import 'package:crocurry/views/bloc/categories/category_bloc.dart';
import 'package:crocurry/views/bloc/categories/category_event.dart';
import 'package:crocurry/views/bloc/filter/filter_bloc.dart';
import 'package:crocurry/views/bloc/filter/filter_event.dart';
import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
import 'package:crocurry/views/bloc/screen/screen_event.dart';
import 'package:crocurry/views/bloc/screen/screen_state.dart';
import 'package:crocurry/views/bloc/search/search_bloc.dart';
import 'package:crocurry/views/bloc/search/search_event.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/screens/components/common_screen.dart';
import 'package:crocurry/views/screens/home/views/components/cart_icon_widget.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List _pages = const [
    HomeSection(),
    DiscoverScreen(),
    // BookmarkScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoggedIn(context);
    });
    super.initState();
  }

  checkLoggedIn(BuildContext context) async {
    var isLoggedIn = await locator<CheckLoggedIn>().call();
    if (context.mounted) {
      if (isLoggedIn) {
        context.read<AuthBloc>().add(LogIn());
      } else {
        context.read<AuthBloc>().add(LogOut());
      }
    }
  }

  checkNetwork(BuildContext context) async {
    var isConnected = (await locator<CheckConnectivity>().call());
    if (!isConnected && context.mounted) {
      CommonDialogs.showAlertDialog(
          context: context,
          description: 'No internet connectivity! Please Try again',
          callBack: () async {
            context.pop();
            checkNetwork(context);
          });
    } else {
      if (context.mounted) {
        updateCategories(context);
      }
    }
  }

  updateCategories(BuildContext context) async {
    final details = await locator<GetProductCategories>().call();
    var list = details.$1 ?? [];
    if (context.mounted) {
      context.read<CategoryBloc>().add(FetchCategories(list));
      context.read<FilterBloc>().add(InitCategoryFilter(list));
    }
  }

  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return DoubleTapToExit(
      child: PopScope(
        canPop: false,
        child: CommonScreen(
          child: BlocBuilder<ScreenBloc, ScreenState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  leading: const SizedBox(),
                  leadingWidth: 0,
                  centerTitle: false,
                  title: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/logo/app_logo.png',
                      width: 170.0,
                      height: 40.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<SearchBloc>().add(ClearSearchList());
                        Navigator.pushNamed(context, searchScreenRoute);
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/Search.svg",
                        height: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).textTheme.bodyLarge!.color!,
                            BlendMode.srcIn),
                      ),
                    ),
                    // const CartIconWidget(),
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, notificationsScreenRoute);
                    //   },
                    //   icon: SvgPicture.asset(
                    //     "assets/icons/Notification.svg",
                    //     height: 24,
                    //     colorFilter: ColorFilter.mode(
                    //         Theme.of(context).textTheme.bodyLarge!.color!,
                    //         BlendMode.srcIn),
                    //   ),
                    // ),
                  ],
                ),
              
                body: CommonScreen(
                  child: PageTransitionSwitcher(
                    duration: defaultDuration,
                    transitionBuilder: (child, animation, secondAnimation) {
                      return FadeThroughTransition(
                        animation: animation,
                        secondaryAnimation: secondAnimation,
                        child: child,
                      );
                    },
                    child: _pages[state.selectedIndex],
                  ),
                ),
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.only(top: defaultPadding / 2),
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xFF101015),
                  child: BottomNavigationBar(
                    currentIndex: state.selectedIndex,
                    onTap: (index) async {
                      var user = context.read<UserBloc>().state.user;
                      if (index == 0) {
                        context.read<CarousalBloc>().add(UpdateIndex(index: 0));
                      }
                      if (index == 2) {
                        context
                            .read<CartBloc>()
                            .add(FetchAndUpdateCartdetails());

                        // context.read<CategoryBloc>().add(
                        //     UpdateCategoryIdAndIndex(id: category, index: 0));

                        // var filters =
                        //     context.read<FilterBloc>().state.getAppliedFilters();
                        // var categoryId =
                        // context.read<AllProductsBloc>().add(FetchAllProducts(
                        //       categoryId: '',
                        //       subCategoryId: '',
                        //       pageNumber: '1',
                        //     ));
                        // var params = context.read<FilterBloc>().state.getParams();
                        // context
                        //     .read<AllProductsBloc>()
                        //     .add(FetchAllProductsWithParams(
                        //       params: params,
                        //       pageNumber: '1',
                        //     ));
                      }
                      // if (user != null) {
                      //   if (index == 2) {
                      //     var userName = user.userName!;
                      //     context
                      //         .read<BookmarkBloc>()
                      //         .add(GetBookmarksList(userName));
                      //   }
                      // }

                      if (index != state.selectedIndex) {
                        context
                            .read<ScreenBloc>()
                            .add(UpdateScreenIndex(index: index));
                      }
                    },
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : const Color(0xFF101015),
                    type: BottomNavigationBarType.fixed,
                    selectedFontSize: 12,
                    selectedItemColor: primaryColor,
                    unselectedItemColor: blackColor.withOpacity(0.8),
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: svgIcon("assets/icons/Category.svg"),
                        activeIcon: svgIcon("assets/icons/Category.svg",
                            color: primaryColor),
                        label: "Discover",
                      ),
                      // BottomNavigationBarItem(
                      //   icon: svgIcon("assets/icons/Bookmark.svg"),
                      //   activeIcon: svgIcon("assets/icons/Bookmark.svg",
                      //       color: primaryColor),
                      //   label: "Wish-List",
                      // ),
                      const BottomNavigationBarItem(
                        // icon: svgIcon("assets/icons/Bag.svg"),
                        // activeIcon: svgIcon("assets/icons/Bag.svg",
                        icon: CartIconWidget(),
                        activeIcon: CartIconWidget(isSelected: true),
                        // color: primaryColor),
                        label: "Cart",
                      ),
                      BottomNavigationBarItem(
                        icon: svgIcon("assets/icons/Profile.svg"),
                        activeIcon: svgIcon("assets/icons/Profile.svg",
                            color: primaryColor),
                        label: "Profile",
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
