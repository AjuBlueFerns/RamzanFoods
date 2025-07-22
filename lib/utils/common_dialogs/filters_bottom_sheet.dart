import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/bloc/all_products/all_products_bloc.dart';
import 'package:crocurry/views/bloc/all_products/all_products_event.dart';
import 'package:crocurry/views/bloc/filter/filter_bloc.dart';
import 'package:crocurry/views/bloc/filter/filter_event.dart';
import 'package:crocurry/views/bloc/filter/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var bgColor = greyColor.withOpacity(0.4);

    return Container(
          height: 500,
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(defaultBorderRadius),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              const Divider(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<FilterBloc, FilterState>(
                        builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 140,
                          height: 350,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.filterTypes.length,
                            itemBuilder: (context, index) {
                              var filter = state.filterTypes[index];
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<FilterBloc>()
                                      .add(UpdateFilterIndex(index));
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  color: index != state.selectedFilterIndex
                                      ? bgColor
                                      : transparentColor,
                                  child: Center(
                                      child: Text(
                                    filter.name,
                                    style: const TextStyle(color: blackColor),
                                  )),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                    Expanded(
                      child: BlocBuilder<FilterBloc, FilterState>(
                          builder: (context, state) {
                        var filter = state.selectedFilter;

                        return SizedBox(
                          width: 140,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: defaultPadding * 2),
                                Wrap(
                                  spacing: defaultPadding,
                                  runSpacing: defaultPadding,
                                  children: state.selectedFilter.filterList
                                      .map((filterListItem) {
                                    var index = state.selectedFilter.filterList
                                        .indexOf(filterListItem);
                                    return GestureDetector(
                                      onTap: () {
                                        var filterBloc =
                                            context.read<FilterBloc>();
                                        filterBloc
                                            .add(UpdateFilterListIndex(index));
                                        filterBloc.add(UpdateFilterList(
                                            filter, filterListItem.id));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: state.selectedFilter
                                                      .selectedIndex ==
                                                  index
                                              ? context.primaryColor
                                              : bgColor,
                                          // border: Border.all(
                                          //   color: state.selectedFilter
                                          //               .selectedIndex ==
                                          //           index
                                          //       ? transparentColor
                                          //       : bgColor,
                                          // ),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          (filterListItem).displayName,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: state.selectedFilter
                                                        .selectedIndex ==
                                                    index
                                                ? lightGreyColor
                                                : blackColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        var filterBloc = context.read<FilterBloc>();
                        // var filters = state.getAppliedFilters();
                        // var list = <String>[];
                        // for (var i in filters) {
                        //   list.add(i.displayName);
                        // }
                        // filterBloc.add(UpdateDisplayTitles(list));

                        filterBloc.add(UpdateSelectedFiltersEvent());
                        context.pop();
                        context
                            .read<AllProductsBloc>()
                            .add(FetchAllProductsWithParams(
                              params: state.getParams(),
                              pageNumber: '1',
                            ));
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                        ),
                        child: const Center(
                          child: Text(
                            'Show Results',
                            style: TextStyle(
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
  }
}