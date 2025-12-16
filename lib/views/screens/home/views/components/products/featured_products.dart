import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/products/product_bloc.dart';
import 'package:crocurry/views/bloc/products/product_state.dart';
import 'package:crocurry/views/screens/home/views/components/products/product_listview.dart';
import 'package:crocurry/views/screens/home/views/components/products/products_skeleton_listview.dart';
import 'package:crocurry/views/screens/home/views/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: defaultPadding / 2),
        SectionTitle(title: productSectionTitles[0]),
        BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          return state.loading[0]
              ? const ProductSkeletonListview(
                  loadItems: true,
                  index: 0,
                  searchStr: "featured",
                )
              : ProductListview(products: state.products[0]);
        })
      ],
    );
  }
}
