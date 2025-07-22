import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/validator/validator_bloc.dart';
import 'package:crocurry/views/bloc/validator/validator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidatorText extends StatelessWidget {
  const ValidatorText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidatorBloc, ValidatorState>(
      builder: (context, state) {
        if (state.message.isEmpty) {
          return const Text(
                '',
                style:  TextStyle(
                  color: whiteColor,
                  fontSize: 12,
                ),
              );
        }
        return Padding(
          padding: const EdgeInsets.only(top: defaultPadding/4),
          child: Row(
            children: [
              const Icon(
                Icons.error,
                color: redColor,
                size: 16,
              ),
              const SizedBox(width: defaultPadding),
              Text(
                state.message,
                style: const TextStyle(
                  color: redColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
