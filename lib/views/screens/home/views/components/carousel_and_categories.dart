import 'package:crocurry/views/screens/home/views/components/categories/categories_listview.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart';
import 'carousel_section.dart';

class CarouselAndCategories extends StatelessWidget {
  const CarouselAndCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CarouselSection(),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Categories",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const CategoriesListview(),
      ],
    );
  }
}
