// ignore_for_file: prefer_const_constructors

import 'package:crocurry/views/screens/home/views/components/best_sellers.dart';
import 'package:crocurry/views/screens/home/views/components/carousel_section.dart';
import 'package:crocurry/views/screens/home/views/components/categories/categories_listview.dart';
import 'package:crocurry/views/screens/home/views/components/flash_sale.dart';
import 'package:crocurry/views/screens/home/views/components/most_popular.dart';
import 'package:flutter/material.dart';
import 'package:crocurry/utils/constants.dart';
import 'components/products/featured_products.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSection(),
              Padding(
                padding: const EdgeInsets.only(
                  top: defaultPadding,
                    left: defaultPadding,
                    right: defaultPadding,
                    bottom: defaultPadding),
                child: Text(
                  "Categories",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              CategoriesListview(),
              FeaturedProducts(),
              FlashSale(),
              MostPopular(),
              BestSellers(),
            ],
          ),
        ),
      ),
    );
  }
}
