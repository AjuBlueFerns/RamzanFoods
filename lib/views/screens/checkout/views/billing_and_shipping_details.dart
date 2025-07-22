import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:crocurry/views/screens/profile/views/components/billing_details_container.dart';
import 'package:crocurry/views/screens/profile/views/components/shipping_details_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillingAndShippingDetails extends StatelessWidget {
  const BillingAndShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        var user = state.user!;
        return Column(
          children: [
            BillingDetailsContainer(user: user),
            const SizedBox(height: defaultPadding * 2),
            ShippingDetailsContainer(user: user),
          ],
        );
      },
    );
  }
}
