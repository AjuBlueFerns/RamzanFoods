import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/bloc/user/user_bloc.dart';
import 'package:crocurry/views/bloc/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressListingScreen extends StatelessWidget {
  const AddressListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Address'),
        titleSpacing: 0,
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        var user = state.user!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: defaultPadding),
                Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: greyColor,
                    ),
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: context.primaryColor.withOpacity(0.4),
                            child: const Icon(Icons.location_pin),
                          ),
                          const SizedBox(width: defaultPadding),
                          const Text(
                            'Billing',
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      if (user.billingAddress != null &&
                          user.billingAddress!.isNotEmpty)
                        Text(user.billingAddress!)
                      else
                        const Text('No address added. Tap to add')
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: greyColor,
                    ),
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: context.primaryColor.withOpacity(0.4),
                            child: const Icon(Icons.location_pin),
                          ),
                          const SizedBox(width: defaultPadding),
                          const Text(
                            'Shipping',
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      if (user.billingAddress != null &&
                          user.billingAddress!.isNotEmpty)
                        Text(user.billingAddress!)
                      else
                        const Text('No address added. Tap to add')
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
