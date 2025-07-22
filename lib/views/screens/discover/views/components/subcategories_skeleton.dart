import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';

class SubcategoriesSkeleton extends StatelessWidget {
  const SubcategoriesSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 165,
          child: Container(
            height: 36,
            // margin: const EdgeInsets.only(left: defaultPadding),
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Container(
              margin: const EdgeInsets.all(defaultPadding),
              height: 10,
              width: 50,
              color: greyColor,
            ),
          ),
        );
      },
    );
  }
}
