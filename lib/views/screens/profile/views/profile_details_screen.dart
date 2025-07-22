import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:crocurry/views/screens/profile/views/components/billing_details_container.dart';
import 'package:crocurry/views/screens/profile/views/components/personal_details_container.dart';
import 'package:crocurry/views/screens/profile/views/components/shipping_details_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
         title: const Text('Profile Details'),
        titleSpacing: 0,
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        var user = state.user!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: defaultPadding),
                PersonalDetailsContainer(user: user),
                const SizedBox(height: defaultPadding * 2),
                BillingDetailsContainer(user: user),
                const SizedBox(height: defaultPadding * 2),
                ShippingDetailsContainer(user: user),
                const SizedBox(height: defaultPadding * 2),
              ],
            ),
          ),
        );
      }),
    );
  }
}
