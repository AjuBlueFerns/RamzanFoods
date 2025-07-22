import 'package:crocurry/domain/use_cases/auth/get_otp.dart';
import 'package:crocurry/domain/use_cases/auth/verify_otp.dart';
import 'package:crocurry/domain/use_cases/user/save_user_details_shared_pref.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:crocurry/views/bloc/auth/auth_event.dart';
import 'package:crocurry/views/bloc/auth/auth_state.dart';
import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
import 'package:crocurry/views/bloc/screen/screen_event.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_event.dart';
import 'package:crocurry/views/bloc/validator/validator_bloc.dart';
import 'package:crocurry/views/bloc/validator/validator_event.dart';
import 'package:crocurry/views/screens/components/common_btn.dart';
import 'package:crocurry/views/screens/components/common_loader.dart';
import 'package:crocurry/views/screens/components/validator_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../views/bloc/auth/auth_bloc.dart';

class OtpDialog extends StatefulWidget {
  const OtpDialog({
    super.key,
    required this.mobile,
    required this.hash,
    this.callback,
  });
  final String mobile;
  final String hash;
  final VoidCallback? callback;

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final _formKey = GlobalKey<FormState>();
  var mobileNum = "";

  String code = "";
  String hash = "";

  FocusNode? focusNode;

  @override
  void initState() {
    context.read<ValidatorBloc>().add(ClearValidationMsgEvent());
    WidgetsBinding.instance.addPostFrameCallback((e) async {
      focusNode = FocusNode();
      focusNode!.requestFocus();
      hash = widget.hash;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: context.isKeyboardOpen ? context.bottomInsets + 315 : 400,
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(defaultBorderRadius),
              ),
            ),
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'OTP Verification',
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(),
                    Text(
                      "We have sent OTP to ${widget.mobile}.",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        focusNode: focusNode,
                        onFieldSubmitted: (value) {
                          code = value;
                          verifyAndNavigate(context);
                        },
                        onSaved: (otp) {
                          code = otp!;
                        },
                        // validator: otpValidator.call,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: "",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ValidatorText(),
                        Align(
                          child: TextButton(
                            child: state.isOtpSending
                                ? const CommonLoader()
                                : const Text("Resend OTP"),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              context.read<AuthBloc>().add(OtpLoading(true));

                              var result =
                                  await locator<GetOtp>().call(widget.mobile);
                              hash = result.$1!;
                              if (context.mounted) {
                                context.read<AuthBloc>().add(OtpLoading(false));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    CommonBtn(
                      onPressed: () async {
                        verifyAndNavigate(context);
                      },
                      child: state.isOtpVerifiying
                          ? const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: greyColor,
                                ),
                              ),
                            )
                          : const Text("Verify OTP"),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  verifyAndNavigate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    if (CommonFunctions.validateOTP(context: context, otp: code)) {
      if(widget.mobile==testPhoneNumber){
        
      }
      context.read<AuthBloc>().add(OtpVerifying(true));
      await locator<VerifyOtp>()
          .call(widget.mobile, code, hash)
          .then((result) async {
        if (result.$1 != null) {
          await locator<SaveUserDetailsSharedPref>()
              .call(result.$1!)
              .then((_) async {
            if (context.mounted) {
              context.read<UserBloc>().add(FetchUserDetailsFromShared());
              context.read<ScreenBloc>().add(UpdateScreenIndex(index: 0));
            }
          });

          if (context.mounted) {
            context.read<AuthBloc>().add(OtpVerifying(false));
            CustomToast.showSuccessMessage(
                context: context, message: 'Login Success!');
            context.read<AuthBloc>().add(LogIn());
            if (widget.callback == null) {
              context.read<ScreenBloc>().add(UpdateScreenIndex(index: 0));
              Navigator.pushNamedAndRemoveUntil(
                  context, homeScreenRoute, (Route<dynamic> route) => false);
            } else {
              context.pop();
              widget.callback!.call();
            }
          }
        } else {
          if (context.mounted) {
            context.read<AuthBloc>().add(OtpVerifying(false));
            // CustomToast.showErrorMessage(
            //     context: context, message: 'Invalid OTP');
            context
                .read<ValidatorBloc>()
                .add(SetValidationMsgEvent('Invalid OTP'));
          }
        }
      });
    }
  }
}
