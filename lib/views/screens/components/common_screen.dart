import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_bloc.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_event.dart';
import 'package:crocurry/views/bloc/carousal/carousal_bloc.dart';
import 'package:crocurry/views/bloc/carousal/carousal_event.dart';
import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
import 'package:crocurry/views/bloc/screen/screen_event.dart';
import 'package:crocurry/views/bloc/screen/screen_state.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CommonScreen extends StatefulWidget {
  final Widget child;

  const CommonScreen({super.key, required this.child});

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
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

    return StreamBuilder<List<ConnectivityResult>>(
        initialData: const [
          ConnectivityResult.wifi,
          ConnectivityResult.mobile,
        ],
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // debugPrint("## hasData");
            if (snapshot.data != null) {
              // debugPrint("## data not null");

              if (!snapshot.data!.contains(ConnectivityResult.none)) {
                return widget.child;
              } else {
                return BlocBuilder<ScreenBloc, ScreenState>(
                    builder: (context, state) {
                  return Scaffold(
                    bottomNavigationBar: Container(
                      padding: const EdgeInsets.only(top: defaultPadding / 2),
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color(0xFF101015),
                      child: BottomNavigationBar(
                        currentIndex: state.selectedIndex,
                        onTap: (index) async {
                          if (index == 0) {
                            context
                                .read<CarousalBloc>()
                                .add(UpdateIndex(index: 0));
                          }
                          if (index == 1) {
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
                          if (index == 2) {
                            var userName =
                                context.read<UserBloc>().state.user!.userName!;
                            context
                                .read<BookmarkBloc>()
                                .add(GetBookmarksList(userName));
                          }
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
                          BottomNavigationBarItem(
                            icon: svgIcon("assets/icons/Bag.svg"),
                            activeIcon: svgIcon("assets/icons/Bag.svg",
                                color: primaryColor),
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
                    appBar: AppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      leading: const SizedBox(),
                      leadingWidth: 0,
                      centerTitle: false,
                      title: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/crocurry-logo-small.png',
                          width: 170.0,
                          height: 40.0,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      // actions: [
                      //   IconButton(
                      //     onPressed: () {
                      //       context.read<SearchBloc>().add(ClearSearchList());
                      //       Navigator.pushNamed(context, searchScreenRoute);
                      //     },
                      //     icon: SvgPicture.asset(
                      //       "assets/icons/Search.svg",
                      //       height: 24,
                      //       colorFilter: ColorFilter.mode(
                      //           Theme.of(context).textTheme.bodyLarge!.color!,
                      //           BlendMode.srcIn),
                      //     ),
                      //   ),
                      //   const CartIconWidget(),
                      //   // IconButton(
                      //   //   onPressed: () {
                      //   //     Navigator.pushNamed(context, notificationsScreenRoute);
                      //   //   },
                      //   //   icon: SvgPicture.asset(
                      //   //     "assets/icons/Notification.svg",
                      //   //     height: 24,
                      //   //     colorFilter: ColorFilter.mode(
                      //   //         Theme.of(context).textTheme.bodyLarge!.color!,
                      //   //         BlendMode.srcIn),
                      //   //   ),
                      //   // ),
                      // ],
                    ),
                    body: Center(
                      child: Text("No Internet Connection"),
                    ),
                  );
                });
              }
            } else {
              // debugPrint("## data is  null !!");
            }
          } else {
            // debugPrint("## has no Data");
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return widget.child;
        });
  }
}
