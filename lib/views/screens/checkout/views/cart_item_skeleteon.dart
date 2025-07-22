import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/screens/components/loading_shimmer.dart';
import 'package:crocurry/views/screens/home/views/components/section_title.dart';
import 'package:flutter/material.dart';

class CartItemSkeleteon extends StatelessWidget {
  const CartItemSkeleteon({super.key, required this.count});
  final int? count;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        const SectionTitle(title: 'Review your order'),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return const Divider(
              color: greyColor,
              indent: 0,
              endIndent: 0,
            );
          },
          shrinkWrap: true,
          itemCount: count ?? 0,
          itemBuilder: (context, index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingShimmer.rectangle(
                  height: 75,
                  width: 75,
                  borderRadius: defaultBorderRadius,
                ),
                const SizedBox(width: defaultPadding / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoadingShimmer.rectangle(
                        height: 15,
                        width: double.infinity,
                      ),
                      const SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
