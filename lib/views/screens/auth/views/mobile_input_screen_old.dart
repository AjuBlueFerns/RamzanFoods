// import 'package:crocurry/domain/use_cases/auth/get_otp.dart';
// import 'package:crocurry/utils/constants.dart';
// import 'package:crocurry/utils/extensions/context_extensions.dart';
// import 'package:crocurry/utils/locator.dart';
// import 'package:crocurry/utils/route/route_constants.dart';
// import 'package:crocurry/views/bloc/auth/auth_bloc.dart';
// import 'package:crocurry/views/bloc/auth/auth_event.dart';
// import 'package:crocurry/views/bloc/auth/auth_state.dart';
// import 'package:crocurry/views/screens/components/common_btn.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MobileInputScreen extends StatefulWidget {
//   const MobileInputScreen({super.key});

//   @override
//   State<MobileInputScreen> createState() => _MobileInputScreenState();
// }

// class _MobileInputScreenState extends State<MobileInputScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   String mobileNum = "";
//   FocusNode? focusNode;

//   @override
//   void initState() {
//     focusNode = FocusNode();
//     focusNode!.requestFocus();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Image.asset(
//                   "assets/images/login_dark.png",
//                   fit: BoxFit.cover,
//                 ),
//                 BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
//                   return Padding(
//                     padding: const EdgeInsets.all(defaultPadding),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Welcome !",
//                           style: Theme.of(context).textTheme.headlineSmall,
//                         ),
//                         const SizedBox(height: defaultPadding / 2),
//                         const Text(
//                           "Log in with your mobile number.",
//                         ),
//                         const SizedBox(height: defaultPadding),
//                         TextFormField(
//                           focusNode: focusNode,
//                           onFieldSubmitted: (value) {
//                              mobileNum = value;
//                             sendOtp(context, state);
//                           },
//                           onSaved: (mobile) {
//                             mobileNum = mobile!;
//                             // sendOtp(context, state);
//                           },
//                           validator: mobileNumValidator.call,
//                           textInputAction: TextInputAction.next,
//                           keyboardType: TextInputType.phone,
//                           decoration: const InputDecoration(
//                             hintText: "Mobile Number",
//                           ),
//                         ),
//                         SizedBox(
//                           height: context.screenHeight > 700
//                               ? context.screenHeight * 0.1
//                               : defaultPadding,
//                         ),
//                         CommonBtn(
//                           onPressed: () async {
//                             sendOtp(context, state);
//                           },
//                           child: state.isOtpSending
//                               ? const Center(
//                                   child: SizedBox(
//                                     height: 20,
//                                     width: 20,
//                                     child: CircularProgressIndicator(
//                                       color: greyColor,
//                                     ),
//                                   ),
//                                 )
//                               : const Text("Get OTP"),
//                         ),
//                       ],
//                     ),
//                   );
//                 })
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   sendOtp(BuildContext context, AuthState state) async {
//     FocusScope.of(context).unfocus();
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       if (!state.isOtpSending) {
//         context.read<AuthBloc>().add(OtpLoading(true));
//         var result = await locator<GetOtp>().call(mobileNum);
//         String? hash = result.$1;

//         if (context.mounted) {
//           if (hash != null) {
//             context.read<AuthBloc>().add(OtpLoading(false));

//             Navigator.pushNamed(context, otpScreenRoute, arguments: [
//               mobileNum,
//               hash,
//             ]);
//           }
//         }
//       }
//     }
//   }
// }
