import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const grandisExtendedFont = "Grandis Extended";

// On color 80, 60.... those means opacity

// const Color primaryColor = Color(0xFF7B61FF);
const Color primaryColor = Color.fromRGBO(165, 131, 17, 1);

const MaterialColor primaryMaterialColor = MaterialColor(
  0xFFA58311, // The primary color value in hex
  <int, Color>{
    50: Color(0xFFF8E8C1),
    100: Color(0xFFF1DDA5),
    200: Color(0xFFEBCF88),
    300: Color(0xFFE5C86D),
    400: Color(0xFFD8B557),
    500: primaryColor, // Main color
    600: Color(0xFFC4A312),
    700: Color(0xFFB49A0F),
    800: Color(0xFFA68D0D),
    900: Color(0xFF8A700B),
  },
);

const Color transparentColor = Colors.transparent;
const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color whileColor10 = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color redColor = Colors.red;

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
// const Color greyColor80 = Color(0xFFC6C4CF);
// const Color greyColor60 = Color(0xFFD4D3DB);
// const Color greyColor40 = Color(0xFFE3E1E7);
// const Color greyColor20 = Color(0xFFF1F0F3);
// const Color greyColor10 = Color(0xFFF8F8F9);
// const Color greyColor5 = Color(0xFFFBFBFC);

// const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'passwords must have at least one special character')
]);

// final mobileNumValidator = MultiValidator([
//   RequiredValidator(errorText: 'Mobile number is required'),
//   MinLengthValidator(mobileNumberINLength, errorText: "Enter a valid Mobile Number"),
//   MaxLengthValidator(mobileNumberINLength, errorText: "Enter a valid Mobile Number"),
// ]);
// final otpValidator = MultiValidator([
//   RequiredValidator(errorText: 'OTP is required'),
//   MaxLengthValidator(6, errorText: "Enter a valid OTP"),
//   MinLengthValidator(6, errorText: "Enter a valid OTP"),
// ]);

const pasNotMatchErrorText = "passwords do not match";

/// api urls and endpoints
const baseUrl = 'https://crocurry.com';
const detailsEndPoint = '/trendcart/api/ajax/ajax_api_handler.php';
const mobileAppEndpoint = '/mobile_app/app_handler.php';
const otpEndPoint = '/trendcart/site_user/checklogin_ot_app_v2.php';
const checkoutEndPoint = '/trendcart/api/mobile_app/mobile_payment_landing.php';

/// List of product list in home screen
const List<String> productSectionTitles = [
  'Featured Products',
  'Flash Sale',
  'Best Sellers',
  'Most popular',
];

/// shared prefs keys
const isLoggedInKey = 'isLoggedIn';
const cartIdKey = 'cartId';
const emailKey = 'email';
const passwordKey = 'password';
const firstNameKey = 'firstName';
const lastNameKey = 'lastName';
const userNameKey = 'userName';
const activationIdKey = 'activationId';
const billingTelephoneKey = 'billingTelephone';
const billingAddressKey = 'billingAddress';
const billingCityKey = 'billingCity';
const billingStateKey = 'billingState';
const billingCountryKey = 'billingCountry';
const billingZipKey = 'billingZip';
const shippingTelephoneKey = 'shippingTelephone';
const shippingAddressKey = 'shippingAddress';
const shippingCityKey = 'shippingCity';
const shippingStateKey = 'shippingState';
const shippingCountryKey = 'shippingCountry';
const shippingZipKey = 'shippingZip';
const showOnboardingScreensKey = 'showOnboardingScreens';

/// for mobile number auth
const countryCodeIN = '+91';
const mobileNumberINLength = 10;

///
const privayPolicyLink =
    'https://crocurry.com/store/privacy-policy/?from_source=mobile_app';
const termsAndConditionsLink =
    'https://crocurry.com/store/terms?from_source=mobile_app';
const returnPolicyLink =
    'https://crocurry.com/store/return-policy?from_source=mobile_app';
const shippingAndDeliveryPolicyLink =
    'https://crocurry.com/store/shipping-and-delivery-policy?from_source=mobile_app';
const deleteAccountLink =
    'https://crocurry.com/store/account/delete-account/?from_source=mobile_app';
const bluefernsWebsiteLink = 'https://blueferns.com';

///
const testPhoneNumberDialCode = '+91';
const testPhoneNumber = '8590919691';
const testOTP = '555555';
const testHash = '3ad12e969b2f4f686b6e8dcb7d8cdb99';
