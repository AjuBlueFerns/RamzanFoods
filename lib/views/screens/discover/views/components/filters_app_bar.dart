import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/bloc/all_products/all_products_bloc.dart';
import 'package:crocurry/views/bloc/all_products/all_products_event.dart';
import 'package:crocurry/views/bloc/filter/filter_bloc.dart';
import 'package:crocurry/views/bloc/filter/filter_event.dart';
import 'package:crocurry/views/bloc/filter/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FiltersAppBar extends StatelessWidget {
  const FiltersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
      var selectedFilters = state.selectedFilters ?? [];
      return SizedBox(
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
          scrollDirection: Axis.horizontal,
          itemCount: selectedFilters.length,
          itemBuilder: (context, index) {
            if (selectedFilters.isEmpty) {
              return const SizedBox.shrink();
            }
            var filter = selectedFilters[index];
            return Container(
              padding: const EdgeInsets.all(defaultPadding / 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: context.primaryColor,
                ),
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              child: Center(
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    Text(
                      filter.filterItem.displayName,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<FilterBloc>()
                            .add(RemoveFilterEvent(filter));

                        /// delaying so that state.getParams gets updated value after filter is removed,
                        /// else the state before removing is taken for getting params
                        Future.delayed(const Duration(milliseconds: 50))
                            .then((_) {
                          if (context.mounted) {
                            context
                                .read<AllProductsBloc>()
                                .add(FetchAllProductsWithParams(
                                  params: state.getParams(),
                                  pageNumber: '1',
                                ));
                          }
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        size: 14,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
