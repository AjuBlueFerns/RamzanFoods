import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    _showLoginView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: SizedBox(
            width: Helper.getWidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Helper.allowHeight(Helper.getHeight(context) / 12),
                Image.asset(
                  'assets/logo/app_logo.png',
                  width: Helper.getWidth(context) / 1.5,
                ),
                Helper.allowHeight(20),
                const Text(
                  "Login Now",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLoginView() {
    Future.delayed(const Duration(milliseconds: 600)).then((_) {
      if (mounted) {
        CommonDialogs.showLoginMobileNumberDialog(context: context, showControlls: false);
      }
    });
  }
}
