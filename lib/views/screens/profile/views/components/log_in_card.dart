import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';

class LogInCard extends StatelessWidget {
  const LogInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        CommonDialogs.showLoginMobileNumberDialog(context: context);
      },
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: primaryColor.withOpacity(0.5),
        child: const Icon(
          Icons.person_2,
          size: 30,
        ),
      ),
      title: const Text('Login / Sign Up'),
    );
  }
}
