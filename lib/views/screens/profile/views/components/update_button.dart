// ignore_for_file: prefer_const_constructors, unused_import


import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:crocurry/views/screens/components/common_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, required this.callback});
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding * 2),
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        return CommonBtn(
          onPressed: () async {
            if (!state.isUpdating!) {
              callback.call();
            }
          },
          child: state.isUpdating!
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: greyColor,
                  ),
                )
              : const Text('Update'),
        );
      }),
    );
  }
}
