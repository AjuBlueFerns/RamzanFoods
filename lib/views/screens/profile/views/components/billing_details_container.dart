import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:flutter/material.dart';

class BillingDetailsContainer extends StatelessWidget {
  const BillingDetailsContainer({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 4),

            Container(
              height: 20,
              width: 6,
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Billing Details',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, billingEditScreenRoute);
              },
              child: Text(
                'Edit',
                style: TextStyle(
                  color: context.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
              border: Border.all(
                color: greyColor,
              ),
              borderRadius: BorderRadius.circular(defaultBorderRadius)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Address"),
                  const Spacer(),
                  Text(
                    user.billingAddress ?? "",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  const Text("City"),
                  const Spacer(),
                  Text(
                    user.billingCity ?? "",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  const Text("State"),
                  const Spacer(),
                  Text(
                    user.billingState ?? "",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  const Text("Country"),
                  const Spacer(),
                  Text(
                    user.billingCountry ?? "",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  const Text("Zip "),
                  const Spacer(),
                  Text(
                    user.billingZip ?? "",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
              // const SizedBox(height: defaultPadding),
              // Row(
              //   children: [
              //     const Text("Telephone "),
              //     const Spacer(),
              //     Text(
              //       user.billingTelephone ?? "",
              //       style: const TextStyle(color: blackColor),
              //     ),
              //   ],
              // ),
            ],
          ),
        )
      ],
    );
  }
}
