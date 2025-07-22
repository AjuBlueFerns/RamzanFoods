import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
import 'package:crocurry/utils/common_dialogs/otp_dialog.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/route/screen_export.dart';
import 'package:crocurry/views/bloc/app_details/app_details_bloc.dart';
import 'package:crocurry/views/bloc/app_details/app_details_state.dart';
import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
import 'package:crocurry/views/bloc/auth/auth_event.dart';
import 'package:crocurry/views/bloc/auth/auth_state.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_bloc.dart';
import 'package:crocurry/views/bloc/bookmark/bookmark_event.dart';
import 'package:crocurry/views/bloc/orders/orders_bloc.dart';
import 'package:crocurry/views/bloc/orders/orders_event.dart';
import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
import 'package:crocurry/views/bloc/screen/screen_event.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_event.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:crocurry/views/screens/profile/views/components/log_in_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
            return authState.isLoggedIn
                ? BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                    return ProfileCard(
                      name:
                          state.user != null ? state.user!.userName ?? "" : "",
                      email: state.user != null ? state.user!.email ?? "" : "",
                      imageSrc: "",
                      press: () {
                        Navigator.pushNamed(context, profileDetailsScreenRoute);
                      },
                    );
                  })
                : const LogInCard();
          }),

          const SizedBox(height: defaultPadding / 2),

          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return ProfileMenuListTile(
              text: "Orders",
              svgSrc: "assets/icons/Order.svg",
              isShowDivider: false,
              press: () async {
                if (state.isLoggedIn) {
                  context.read<OrdersBloc>().add(FetchOrders());
                  Navigator.pushNamed(context, ordersScreenRoute);
                } else {
                  CustomToast.showInfoMessage(
                      context: context, message: 'Login to view Orders');
                }
              },
            );
          }),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return ProfileMenuListTile(
              text: "Wishlist",
              svgSrc: "assets/icons/Order.svg",
              isShowDivider: true,
              press: () async {
                if (state.isLoggedIn) {
                  var userName = context.read<UserBloc>().state.user!.userName!;
                  context.read<BookmarkBloc>().add(GetBookmarksList(userName));

                  Navigator.pushNamed(context, bookmarkScreenRoute);
                } else {
                  CustomToast.showInfoMessage(
                      context: context, message: 'Login to view wishlist');
                }
              },
            );
          }),
          // ProfileMenuListTile(
          //   text: "Returns",
          //   svgSrc: "assets/icons/Return.svg",
          //   press: () {},
          // ),
          // ProfileMenuListTile(
          //   text: "Wishlist",
          //   svgSrc: "assets/icons/Wishlist.svg",
          //   press: () {},
          // ),
          // ProfileMenuListTile(
          //   text: "Addresses",
          //   svgSrc: "assets/icons/Address.svg",
          //   press: () {
          //     Navigator.pushNamed(context, addressListingScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Payment",
          //   svgSrc: "assets/icons/card.svg",
          //   press: () {
          //     Navigator.pushNamed(context, emptyPaymentScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Wallet",
          //   svgSrc: "assets/icons/Wallet.svg",
          //   press: () {
          //     Navigator.pushNamed(context, walletScreenRoute);
          //   },
          // ),
          // const SizedBox(height: defaultPadding),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: defaultPadding, vertical: defaultPadding / 2),
          //   child: Text(
          //     "Personalization",
          //     style: Theme.of(context).textTheme.titleSmall,
          //   ),
          // ),
          // DividerListTileWithTrilingText(
          //   svgSrc: "assets/icons/Notification.svg",
          //   title: "Notification",
          //   trilingText: "Off",
          //   press: () {
          //     Navigator.pushNamed(context, enableNotificationScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Preferences",
          //   svgSrc: "assets/icons/Preferences.svg",
          //   press: () {
          //     Navigator.pushNamed(context, preferencesScreenRoute);
          //   },
          // ),
          // const SizedBox(height: defaultPadding),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: defaultPadding, vertical: defaultPadding / 2),
          //   child: Text(
          //     "Settings",
          //     style: Theme.of(context).textTheme.titleSmall,
          //   ),
          // ),
          // ProfileMenuListTile(
          //   text: "Language",
          //   svgSrc: "assets/icons/Language.svg",
          //   press: () {
          //     Navigator.pushNamed(context, selectLanguageScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Location",
          //   svgSrc: "assets/icons/Location.svg",
          //   press: () {},
          // ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 4),
            child: Text(
              "Help & Support",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          // ProfileMenuListTile(
          //   text: "Get Help",
          //   svgSrc: "assets/icons/Help.svg",
          //   press: () {
          //     // Navigator.pushNamed(context, getHelpScreenRoute);
          //   },
          // ),
          ProfileMenuListTile(
            text: "Privacy Policy",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {
              Navigator.pushNamed(
                context,
                webViewScreenRoute,
                arguments: ["Privacy Policy", privayPolicyLink],
              );
            },
          ),
          ProfileMenuListTile(
            text: "Refund Policy",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {
              Navigator.pushNamed(
                context,
                webViewScreenRoute,
                arguments: ["Refund Policy", returnPolicyLink],
              );
            },
          ),
          ProfileMenuListTile(
            text: "Shipping & Delivery Policy",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {
              Navigator.pushNamed(
                context,
                webViewScreenRoute,
                arguments: [
                  "Shipping & Delivery Policy",
                  shippingAndDeliveryPolicyLink
                ],
              );
            },
          ),
          ProfileMenuListTile(
            text: "Terms & Conditions",
            svgSrc: "assets/icons/FAQ.svg",
            press: () {
              Navigator.pushNamed(
                context,
                webViewScreenRoute,
                arguments: ["Terms & Conditions", termsAndConditionsLink],
              );
            },
            isShowDivider: true,
          ),
          // const SizedBox(height: defaultPadding),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (!state.isLoggedIn) {
                return const SizedBox.shrink();
              }
              return SizedBox(
                height: 40,
                child: ListTile(
                  onTap: () async {
                    CommonDialogs.showConfirmDialog(
                      callBack: () {
                        context.pop();
                        Navigator.pushNamed(
                          context,
                          webViewScreenRoute,
                          arguments: [
                            'Delete Account',
                            deleteAccountLink,
                          ],
                        );
                      },
                      context: context,
                      description:
                          'Are you sure to delete your account? This cannot be undone.',
                    );
                  },
                  minLeadingWidth: 24,
                  leading: const Icon(Icons.delete_outline_rounded),
                  title: const Text(
                    "Delete account",
                    style: TextStyle(fontSize: 14, height: 1),
                  ),
                ),
              );
            },
          ),
          // Log Out
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return state.isLoggedIn
                ? ListTile(
                    onTap: () async {
                      CommonDialogs.showConfirmDialog(
                        context: context,
                        description: 'Are you sure to logout?',
                        callBack: () async {
                          context.read<AuthBloc>().add(LogOut());
                          context.read<UserBloc>().add(ClearUserDetailsEvent());
                          if (context.mounted) {
                            context
                                .read<ScreenBloc>()
                                .add(UpdateScreenIndex(index: 0));
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                homeScreenRoute,
                                (Route<dynamic> route) => false);
                          }
                        },
                      );
                    },
                    minLeadingWidth: 24,
                    leading: SvgPicture.asset(
                      "assets/icons/Logout.svg",
                      height: 24,
                      width: 24,
                      colorFilter: const ColorFilter.mode(
                        errorColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: const Text(
                      "Log Out",
                      style:
                          TextStyle(color: errorColor, fontSize: 14, height: 1),
                    ),
                  )
                : ListTile(
                    onTap: () async {
                      CommonDialogs.showLoginMobileNumberDialog(
                          context: context);
                    },
                    minLeadingWidth: 24,
                    leading: SvgPicture.asset(
                      "assets/icons/Logout.svg",
                      height: 24,
                      width: 24,
                      colorFilter: const ColorFilter.mode(
                        errorColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    title: const Text(
                      "Login / Sign Up",
                      style:
                          TextStyle(color: errorColor, fontSize: 14, height: 1),
                    ),
                  );
          }),
          // const SizedBox(height: defaultPadding),s
          BlocBuilder<AppDetailsBloc, AppDetailsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: Text(
                    'Version : ${state.versionNumber}+${state.buildNumber}'),
              );
            },
          ),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Row(
              children: [
                const Text('App developed by '),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      webViewScreenRoute,
                      arguments: [
                        "",
                        bluefernsWebsiteLink,
                      ],
                    );
                  },
                  child: const Text(
                    'Blueferns Technologies ',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
