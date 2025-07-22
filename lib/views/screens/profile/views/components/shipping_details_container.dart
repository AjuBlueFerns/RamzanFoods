import 'package:crocurry/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/utils/route/route_constants.dart';

class ShippingDetailsContainer extends StatelessWidget {
  const ShippingDetailsContainer({super.key, required this.user});
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
              'Shipping Details',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, shippingEditScreenRoute);
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
                    user.shippingAddress ?? "",
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
                    user.shippingCity ?? "",
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
                    user.shippingState ?? "",
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
                    user.shippingCountry ?? "",
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
                    user.shippingZip ?? "",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  const Text("Telephone "),
                  const Spacer(),
                  Text(
                    user.shippingTelephone ?? "",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
