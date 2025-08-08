import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/bloc/auth/auth_state.dart';
import 'package:crocurry/views/bloc/validator/validator_bloc.dart';
import 'package:crocurry/views/bloc/validator/validator_event.dart';
import 'package:crocurry/views/screens/components/common_btn.dart';
import 'package:crocurry/views/screens/components/validator_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../views/bloc/auth/auth_bloc.dart';

class LoginMobileNumDialog extends StatefulWidget {
  const LoginMobileNumDialog(
      {super.key,
      required this.title,
      this.callback,
      this.showControlls = true});
  final String title;
  final VoidCallback? callback;
  final bool? showControlls;

  @override
  State<LoginMobileNumDialog> createState() => _LoginMobileNumDialogState();
}

class _LoginMobileNumDialogState extends State<LoginMobileNumDialog> {
  final _formKey = GlobalKey<FormState>();
  var mobileNum = "";
  FocusNode? focusNode;

  @override
  void initState() {
    context.read<ValidatorBloc>().add(ClearValidationMsgEvent());
    focusNode = FocusNode();
    focusNode!.requestFocus();
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 28),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showControlls!)
                    const SizedBox(height: defaultPadding),
                  if (widget.showControlls!)
                    Row(
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
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
                  if (widget.showControlls!) const Divider(),
                  const Text(
                    "Continue with your mobile number.",
                    style: TextStyle(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const SizedBox(
                          width: 60,
                          child: Center(
                            child: Text(
                              countryCodeIN,
                              style: TextStyle(
                                fontSize: 16,
                                color: blackColor,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            focusNode: focusNode,
                            onFieldSubmitted: (value) async {
                              mobileNum = value;
                              if (!state.isOtpSending) {
                                await CommonFunctions.sendOtp(
                                  context: context,
                                  mobileNum: mobileNum,
                                  callback: widget.callback,
                                );
                              }
                            },
                            onSaved: (mobile) {
                              mobileNum = mobile!;
                              // sendOtp(context, state);
                            },
                            // validator: mobileNumValidator.call,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              fillColor: Colors.transparent,
                              hintText: "Mobile Number",
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const ValidatorText(),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonBtn(
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (!state.isOtpSending) {
                        await CommonFunctions.sendOtp(
                          context: context,
                          mobileNum: mobileNum,
                          callback: widget.callback,
                          showControlls:false,
                        );
                      }
                    },
                    child: state.isOtpSending
                        ? const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: greyColor,
                              ),
                            ),
                          )
                        : const Text("Get OTP"),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
