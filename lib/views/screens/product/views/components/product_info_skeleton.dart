import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/screens/components/loading_shimmer.dart';
import 'package:flutter/material.dart';

class ProductInfoSkeleton extends StatelessWidget {
  const ProductInfoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadingShimmer.rectangle(height: 20, width: 50),
            const SizedBox(height: defaultPadding / 2),
            LoadingShimmer.rectangle(height: 35, width: 250),
            const SizedBox(height: defaultPadding * 2),
            Text(
              "Product info",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: defaultPadding / 2),
            LoadingShimmer.rectangle(height: 15, width: double.infinity),
            const SizedBox(height: defaultPadding),
            LoadingShimmer.rectangle(height: 15, width: double.infinity),
            const SizedBox(height: defaultPadding),
            LoadingShimmer.rectangle(height: 15, width: double.infinity),
            const SizedBox(height: defaultPadding),
          ],
        ),
      ),
    );
  }
}
