// import 'package:crocurry/domain/use_cases/auth/get_otp.dart';
// import 'package:crocurry/domain/use_cases/auth/verify_otp.dart';
// import 'package:crocurry/domain/use_cases/connectivity/check_connectivity_repo.dart';
// import 'package:crocurry/domain/use_cases/user/save_user_details_shared_pref.dart';
// import 'package:crocurry/utils/constants.dart';
// import 'package:crocurry/utils/custom_toast.dart';
// import 'package:crocurry/utils/extensions/context_extensions.dart';
// import 'package:crocurry/utils/locator.dart';
// import 'package:crocurry/utils/route/screen_export.dart';
// import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
// import 'package:crocurry/views/bloc/auth/auth_event.dart';
// import 'package:crocurry/views/bloc/auth/auth_state.dart';
// import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
// import 'package:crocurry/views/bloc/screen/screen_event.dart';
// import 'package:crocurry/views/bloc/user/user_bloc.dart';
// import 'package:crocurry/views/bloc/user/user_event.dart';
// import 'package:crocurry/views/screens/components/common_btn.dart';
// import 'package:crocurry/views/screens/components/common_loader.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key, required this.mobile, required this.hash});
//   final String mobile;
//   final String hash;

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String code = "";
//   String hash = "";

//   FocusNode? focusNode;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((e) async {
//       focusNode = FocusNode();
//       focusNode!.requestFocus();
//       hash = widget.hash;
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Image.asset(
//               //   "assets/images/login_dark.png",
//               //   fit: BoxFit.cover,
//               // ),
//               const SizedBox(height: 300),
//               BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
//                 return Padding(
//                   padding: const EdgeInsets.all(0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "OTP Verification!",
//                         style: Theme.of(context).textTheme.headlineSmall,
//                       ),
//                       const SizedBox(height: defaultPadding / 2),
//                       Text(
//                         "We have sent OTP to ${widget.mobile}.",
//                       ),
//                       const SizedBox(height: defaultPadding),
//                       TextFormField(
//                         focusNode: focusNode,
//                         onFieldSubmitted: (value) {
//                           code = value;
//                           verifyAndNavigate(context);
//                         },
//                         onSaved: (otp) {
//                           code = otp!;
//                         },
//                         validator: otpValidator.call,
//                         textInputAction: TextInputAction.done,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           hintText: "",
//                         ),
//                       ),
//                       Align(
//                         child: TextButton(
//                           child: state.isOtpSending
//                               ? const CommonLoader()
//                               : const Text("Resend OTP"),
//                           onPressed: () async {
//                             FocusScope.of(context).unfocus();

//                             context.read<AuthBloc>().add(OtpLoading(true));

//                             var result =
//                                 await locator<GetOtp>().call(widget.mobile);
//                             hash = result.$1!;
//                             if (context.mounted) {
//                               context.read<AuthBloc>().add(OtpLoading(false));
//                             }
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: context.screenHeight > 700
//                             ? context.screenHeight * 0.1
//                             : defaultPadding,
//                       ),
//                       CommonBtn(
//                         onPressed: () async {
//                           verifyAndNavigate(context);
//                         },
//                         child: state.isOtpVerifiying
//                             ? const Center(
//                                 child: SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     color: greyColor,
//                                   ),
//                                 ),
//                               )
//                             : const Text("Verify OTP"),
//                       ),
//                     ],
//                   ),
//                 );
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   verifyAndNavigate(BuildContext context) async {
//     FocusScope.of(context).unfocus();
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       context.read<AuthBloc>().add(OtpVerifying(true));
//       await locator<VerifyOtp>()
//           .call(widget.mobile, code, hash)
//           .then((result) async {
//         if (result.$1 != null) {
//           await locator<SaveUserDetailsSharedPref>()
//               .call(result.$1!)
//               .then((_) async {
//             if (context.mounted) {
//               context.read<UserBloc>().add(FetchUserDetailsFromShared());
//               context.read<ScreenBloc>().add(UpdateScreenIndex(index: 0));
//             }
//           });

//           if (context.mounted) {
//             context.read<AuthBloc>().add(OtpVerifying(false));
//             CustomToast.showSuccessMessage(
//                 context: context, message: 'Login Success!');
//             Navigator.pushNamed(context, homeScreenRoute);
//           }
//         } else {
//           if (context.mounted) {
//             context.read<AuthBloc>().add(OtpVerifying(false));
//             CustomToast.showErrorMessage(
//                 context: context, message: 'Invalid OTP');
//           }
//         }
//       });
//     }
//   }
// }
