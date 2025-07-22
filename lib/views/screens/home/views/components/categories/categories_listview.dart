import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/all_products/all_products_bloc.dart';
import 'package:crocurry/views/bloc/all_products/all_products_event.dart';
import 'package:crocurry/views/bloc/categories/category_bloc.dart';
import 'package:crocurry/views/bloc/categories/category_state.dart';
import 'package:crocurry/views/bloc/filter/filter_bloc.dart';
import 'package:crocurry/views/bloc/filter/filter_event.dart';
import 'package:crocurry/views/bloc/screen/screen_bloc.dart';
import 'package:crocurry/views/bloc/screen/screen_event.dart';
import 'package:crocurry/views/screens/home/views/components/categories/category_chip_item.dart';
import 'package:crocurry/views/screens/home/views/components/categories/category_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesListview extends StatelessWidget {
  const CategoriesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (state.loading)
              ...List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? defaultPadding : defaultPadding / 2,
                      right: index == 3 ? defaultPadding : 0),
                  child: const CategorySkeleton(),
                ),
              )
            else
              ...List.generate(
                state.categories.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? defaultPadding : defaultPadding / 2,
                      right: index == state.categories.length - 1
                          ? defaultPadding
                          : 0),
                  child: CategoryChipItem(
                    homeScreenList: true,
                    category: state.categories[index],
                    // isActive: index == 0,
                    isActive: false,
                    press: () {
                      var filterBloc = context.read<FilterBloc>();
                      filterBloc.add(ClearFiltersEvent());
                      filterBloc.add(UpdateFilterIndex(0));
                      filterBloc.add(UpdateFilterListIndex(index));
                      filterBloc.add(UpdateSelectedFiltersEvent());
                      context
                          .read<ScreenBloc>()
                          .add(UpdateScreenIndex(index: 1));
                    },
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
