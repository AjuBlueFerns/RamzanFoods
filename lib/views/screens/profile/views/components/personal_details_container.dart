import 'package:crocurry/data/models/user_model.dart';
import 'package:crocurry/utils/route/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';

class PersonalDetailsContainer extends StatelessWidget {
  const PersonalDetailsContainer({super.key, required this.user});
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
              'Personal',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, editProfileScreenRoute);
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
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Name"),
                  const Spacer(),
                  Text(
                    "${user.firstName!} ${user.lastName!}",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  const Text("Phone Number"),
                  const Spacer(),
                  Text(
                    "${user.userName}",
                    style: const TextStyle(color: blackColor),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  const Text("Email"),
                  const Spacer(),
                  Text(
                    "${user.email}",
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
