// import 'package:crocurry/domain/use_cases/auth/get_otp.dart';
// import 'package:crocurry/domain/use_cases/connectivity/check_connectivity_repo.dart';
// import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
// import 'package:crocurry/utils/common_functions.dart';
// import 'package:crocurry/utils/constants.dart';
// import 'package:crocurry/utils/custom_toast.dart';
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
//     setState(() {});
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
//             return Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/img1.png',
//                     width: 150,
//                     height: 150,
//                     // color: context.primaryColor,
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   const Text(
//                     "Welcome !",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   const Text(
//                     "Log in with your mobile number.",
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     height: 55,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 1,
//                         color: Colors.grey,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         const SizedBox(
//                           width: 60,
//                           child: Center(
//                             child: Text(
//                               countryCodeIN,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: blackColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const Text(
//                           "|",
//                           style: TextStyle(fontSize: 33, color: Colors.grey),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                           child: TextFormField(
//                             focusNode: focusNode,
//                             onFieldSubmitted: (value) {
//                               mobileNum = value;
//                               sendOtp(context, state);
//                             },
//                             onSaved: (mobile) {
//                               mobileNum = mobile!;
//                               // sendOtp(context, state);
//                             },
//                             validator: mobileNumValidator.call,
//                             textInputAction: TextInputAction.next,
//                             keyboardType: TextInputType.phone,
//                             decoration: const InputDecoration(
//                               fillColor: Colors.transparent,
//                               hintText: "Mobile Number",
//                               border: InputBorder.none,
//                               enabledBorder: InputBorder.none,
//                               focusedBorder: InputBorder.none,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   CommonBtn(
//                     onPressed: () async {
//                       sendOtp(context, state);
//                     },
//                     child: state.isOtpSending
//                         ? const Center(
//                             child: SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(
//                                 color: greyColor,
//                               ),
//                             ),
//                           )
//                         : const Text("Get OTP"),
//                   ),
//                 ],
//               ),
//             );
//           }),
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
