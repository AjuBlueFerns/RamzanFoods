import 'package:crocurry/data/models/product_details_model.dart';
import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/domain/use_cases/auth/get_otp.dart';
import 'package:crocurry/domain/use_cases/cart/add_to_cart.dart';
import 'package:crocurry/domain/use_cases/cart/check_order_status.dart';
import 'package:crocurry/domain/use_cases/cart/clear_cart_id.dart';
import 'package:crocurry/domain/use_cases/cart/get_cart_id.dart';
import 'package:crocurry/domain/use_cases/cart/view_cart.dart';
import 'package:crocurry/domain/use_cases/user/get_user_details_from_shared.dart';
import 'package:crocurry/domain/use_cases/user/update_user_details.dart';
import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
import 'package:crocurry/views/bloc/auth/auth_event.dart';
import 'package:crocurry/views/bloc/cart/cart_bloc.dart';
import 'package:crocurry/views/bloc/cart/cart_event.dart';
import 'package:crocurry/views/bloc/quantity/quantity_bloc.dart';
import 'package:crocurry/views/bloc/quantity/quantity_event.dart';
import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
import 'package:crocurry/views/bloc/screen/screen_event.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_event.dart';
import 'package:crocurry/views/bloc/validator/validator_bloc.dart';
import 'package:crocurry/views/bloc/validator/validator_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonFunctions {
  static Future navigateToProductDetails(
    BuildContext context,
    ProductModel product,
  ) async {
    Navigator.pushNamed(context, productDetailsScreenRoute, arguments: product);
  }

  static Future<bool> checkIfItemCanBeAdded(
      {required BuildContext context,
      required ProductDetailsModel product,
      required int stockQty,
      required int newQty}) async {
    var status = false;
    var itemPresentInCart = false;
    context.read<QuantityBloc>().add(AddingCartStatus(true));
    if (newQty > stockQty) {
      debugPrint("## case1");
      CustomToast.showErrorMessage(
        context: context,
        message:
            'Error: You can only add up to ${product.qtyInStock!} items of this product. Please adjust your quantity! ',
      );
      context.read<QuantityBloc>().add(AddingCartStatus(false));

      return false;
    } else {
      debugPrint("## case2");

      var cartResponse = await locator<ViewCart>().call();
      if (cartResponse.$1 != null) {
        var cartItems = cartResponse.$1!.items;

        if (cartItems != null && cartItems.isNotEmpty) {
          itemPresentInCart =
              cartItems.indexWhere((e) => e.productId! == product.productId!) !=
                  -1;

          if (itemPresentInCart) {
            var index =
                cartItems.indexWhere((e) => e.productId! == product.productId!);
            var cartQty = cartItems[index].quantity;
            debugPrint("### cartQty : $cartQty");
            debugPrint("### stockQty : $stockQty");
            if ((cartQty!.toInt() + newQty) > stockQty) {
              if (context.mounted) {
                CustomToast.showErrorMessage(
                  context: context,
                  action: SnackBarAction(
                      label: 'View Cart',
                      onPressed: () {
                        Navigator.pushNamed(context, cartScreenRoute,
                            arguments: true);
                      }),
                  message:
                      'Error: You can only add up to ${product.qtyInStock!} items of this product. Please adjust your quantity! ',
                );
              }
              status = false;
              if (context.mounted) {
                context.read<QuantityBloc>().add(AddingCartStatus(false));
              }

              return true;
            }
          }
        }
      }
      status = true;
      if (status) {
        await locator<AddToCart>()
            .call(newQty, product.productId!)
            .then((_) async {
          if (context.mounted) {
            var value = itemPresentInCart
                ? cartResponse.$1!.items!.length
                : cartResponse.$1 == null
                    ? 1
                    : cartResponse.$1!.items!.length + 1;
            context.read<CartBloc>().add(UpdateItemQty(
                product.productId!, newQty.toString(), product.price!));
            context.read<CartBloc>().add(UpdateCartCount(value));
            CustomToast.showSuccessMessage(
                action: SnackBarAction(
                    label: 'View Cart',
                    onPressed: () {
                      Navigator.pushNamed(context, cartScreenRoute,
                          arguments: true);
                    }),
                context: context,
                message: 'Item added to cart!');
          }
          if (context.mounted) {
            context.read<QuantityBloc>().add(AddingCartStatus(false));
          }
        });
        return true;
      }
    }
  }

  static Future performCheckout(
    BuildContext context, {
    bool shouldPop = false,
    bool retry = false,
    String? cartId,
  }) async {
    var userDetails = await locator<GetUserDetailsFromShared>().call();
    if ((userDetails.billingAddress ?? "").isEmpty ||
        (userDetails.billingCity ?? "").isEmpty ||
        (userDetails.billingState ?? "").isEmpty ||
        (userDetails.billingCountry ?? "").isEmpty ||
        (userDetails.billingZip ?? "").isEmpty ||
        (userDetails.shippingAddress ?? "").isEmpty ||
        (userDetails.shippingCity ?? "").isEmpty ||
        (userDetails.shippingState ?? "").isEmpty ||
        (userDetails.shippingCountry ?? "").isEmpty ||
        (userDetails.shippingZip ?? "").isEmpty) {
      if (context.mounted) {
        CustomToast.showErrorMessage(
            context: context,
            message:
                'Billing / Shipping details are missing in your profile. Please fill them to proceed !');
        // navigateToHome(context, screenIndexToUpdate: 3);
        // Navigator.pushNamed(context, profileDetailsScreenRoute);

        return;
      }
    }
    var userId = userDetails.userName!;
    cartId ??= await locator<GetCartId>().call();
    var url = baseUrl + checkoutEndPoint;
    url = "$url?cart_id=$cartId&user_id=$userId&from_source=mobile_app";
    if (retry) {
      url += "&retry_payment=true";
    } else {
      await locator<ClearCartId>().call();
    }

    if (!context.mounted) {
      return;
    }
    await Navigator.pushNamed(context, checkoutScreenRoute,
        arguments: [url, cartId]).then((_) {
      if (context.mounted) {
        checkOrderStatus(
          context,
          cartId!,
          shouldPop: shouldPop,
        );
        navigateToHome(context);
      }
    });
  }

  static Future checkOrderStatus(BuildContext context, String cartId,
      {bool shouldPop = true}) async {
    var response = await locator<CheckOrderStatus>().call(cartId);
    if (response.$1 != null) {
      if (response.$1!) {
        /// payment returned success
        if (context.mounted) {
          context.pop();
          await locator<ClearCartId>().call();
          if (context.mounted) {
            navigateToHome(context);
          }
        }
      } else {
        /// payment returned failed
        if (shouldPop) {
          if (context.mounted) {
            context.pop();
            if (context.mounted) {
              navigateToHome(context);
            }
          }
        }
      }
      debugPrint("### response ${response.$1!}");
    }
  }

  static String floatingValuedString(var value, {required String? key}) {
    try {
      // debugPrint("##  key $key  with type ${value.runtimeType}, value $value");
      if (value is String) {
        return (value).replaceAll(",", "").toDouble().toStringAsFixed(2);
      }
      if (value.runtimeType == int) {
        return (value as int).toDouble().toStringAsFixed(2);
      }

      if (value.runtimeType is double) {
        return (value as double).toStringAsFixed(2);
      }
      return value.toString().toDouble().toStringAsFixed(2);
    } catch (err) {
      debugPrint(
          "## errorrrrrr for key $key  with type ${value.runtimeType} value $value ");
      throw Exception(" errorrrrrr");
    }
  }

  static navigateToHome(BuildContext context,
      {int screenIndexToUpdate = 0}) async {
    context
        .read<ScreenBloc>()
        .add(UpdateScreenIndex(index: screenIndexToUpdate));
    Navigator.pushNamedAndRemoveUntil(
        context, homeScreenRoute, (Route<dynamic> route) => false);
  }

  static updateUserDetails(
    BuildContext context,
    UserModel? editingDetails,
  ) async {
    context.read<UserBloc>().add(UpdateStatus(true));
    await locator<UpdateUserDetails>().call(editingDetails!).then((_) {
      if (context.mounted) {
        context.read<UserBloc>().add(UpdateDetails(editingDetails));
        context.pop();
      }
    });
  }

  static bool validateMobileNumber({
    required BuildContext context,
    required String mobile,
  }) {
    var msg = "";
    if (mobile.isEmpty) {
      msg = "Enter mobile number";
    }
    if (mobile.length != mobileNumberINLength) {
      debugPrint("## mobile length :${mobile.length}");
      debugPrint("## mobileNumberINLength :$mobileNumberINLength}");
      msg = "Enter a valid mobile number";
    }
    // if (msg.isNotEmpty) {
    // }
    context.read<ValidatorBloc>().add(SetValidationMsgEvent(msg));

    return msg.isEmpty;
  }

  static bool validateOTP({
    required BuildContext context,
    required String otp,
  }) {
    var msg = "";

    if (otp.isEmpty) {
      msg = "Enter OTP";
    }
    if (otp.length != 6) {
      msg = "Enter a valid OTP";
    }
    // if (msg.isNotEmpty) {
    //   CustomToast.showErrorMessage(context: context, message: msg);
    // }
    context.read<ValidatorBloc>().add(SetValidationMsgEvent(msg));

    return msg.isEmpty;
  }

  static Future sendOtp({
    required BuildContext context,
    required String mobileNum,
    VoidCallback? callback,
  }) async {
    FocusScope.of(context).unfocus();
    var isValid = validateMobileNumber(context: context, mobile: mobileNum);
    if (isValid) {
      if (mobileNum == testPhoneNumber) {
        CommonDialogs.showOtpDialog(
          context: context,
          mobile: mobileNum,
          hash: testHash,
          callback: callback,
        );
      } else {
        context.read<AuthBloc>().add(OtpLoading(true));
        var result = await locator<GetOtp>().call(mobileNum);
        String? hash = result.$1;

        if (context.mounted) {
          if (hash != null) {
            context.read<AuthBloc>().add(OtpLoading(false));
            context.pop();
            CommonDialogs.showOtpDialog(
              context: context,
              mobile: mobileNum,
              hash: hash,
              callback: callback,
            );
          }
        }
      }
    }
  }
}
