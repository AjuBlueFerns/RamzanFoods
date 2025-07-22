import 'package:crocurry/utils/common_dialogs/common_dialogs.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:crocurry/views/bloc/all_products/all_products_bloc.dart';
import 'package:crocurry/views/bloc/all_products/all_products_event.dart';
import 'package:crocurry/views/bloc/filter/filter_bloc.dart';
import 'package:crocurry/views/bloc/filter/filter_event.dart';
import 'package:crocurry/views/bloc/filter/filter_state.dart';
import 'package:crocurry/views/screens/discover/views/components/filters_app_bar.dart';
import 'package:crocurry/views/screens/discover/views/components/product_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProducts(context);
    });
    super.initState();
  }

  getProducts(BuildContext context) async {
    var filterBloc = context.read<FilterBloc>();

    // var filters = filterBloc.state.getAppliedFilters();
    // var list = <String>[];
    // for (var i in filters) {
    //   list.add(i.displayName);
    // }
    // filterBloc.add(UpdateDisplayTitles(list));
    var params = filterBloc.state.getParams();
    context.read<AllProductsBloc>().add(FetchAllProductsWithParams(
          params: params,
          pageNumber: '1',
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        title: const FiltersAppBar(),
        // titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: () async {
              // final details = await locator<GetProductCategories>().call();
              // var list = details.$1 ?? [];
              // if (context.mounted) {
              //   context.read<FilterBloc>().add(InitCategoryFilter(list));
              // }
              context.read<FilterBloc>().add(UpdateFilterIndex(0));
              if (context.mounted) {
                await CommonDialogs.showFiltersBottomSheet(context: context);
              }
            },
            child: Container(
             padding: const EdgeInsets.all(defaultPadding / 4)+ EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: blackColor80,
                ),
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              child: Row(
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(
                      color: context.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                  const Icon(
                    Icons.filter_alt_outlined,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: defaultPadding),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: defaultPadding),
              //   child: SearchForm(),
              // ),
              // SizedBox(height: defaultPadding / 2),
              // Text(
              //   "Categories",
              //   style: Theme.of(context).textTheme.titleSmall,
              // ),
              // const SizedBox(height: defaultPadding / 2),
              // BlocBuilder<CategoryBloc, CategoryState>(
              //     builder: (context, state) {
              //   return Container(
              //     height: 42,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: defaultPadding),
              //     decoration: BoxDecoration(
              //       color: Colors.transparent,
              //       border: Border.all(
              //         color: Theme.of(context).dividerColor,
              //       ),
              //       borderRadius: const BorderRadius.all(
              //         Radius.circular(defaultBorderRadius),
              //       ),
              //     ),
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton<String>(
              //         isExpanded: false,
              //         items: state.categories.map<DropdownMenuItem<String>>(
              //             (CategoryModel category) {
              //           return DropdownMenuItem<String>(
              //             value: category.mainCategoryId!,
              //             child: Text(
              //               category.productCategoryName!.trim(),
              //               style: Theme.of(context).textTheme.titleSmall,
              //             ),
              //           );
              //         }).toList(),
              //         value: state.selectedCategoryId,
              //         onChanged: (String? categoryId) {
              //           context.read<CategoryBloc>().add(
              //               UpdateCategoryIdAndIndex(
              //                   id: categoryId!, index: 0));
              //           context
              //               .read<SubcategoryBloc>()
              //               .add(FetchSubcategories(category: categoryId));
              //           context
              //               .read<AllProductsBloc>()
              //               .add(ClearProductList());
              //           context
              //               .read<SubcategoryBloc>()
              //               .add(UpdateSubCategoryIndex(index: 0));
              //         },
              //       ),
              //     ),
              //   );
              // }),
              // BlocBuilder<CategoryBloc, CategoryState>(
              //   builder: (context, state) {
              //     return GridView.builder(
              //       shrinkWrap: true,
              //       physics: const NeverScrollableScrollPhysics(),
              //       gridDelegate:
              //           const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         childAspectRatio: 4,
              //         crossAxisSpacing: 4,
              //       ),
              //       itemCount: state.categories.length,
              //       itemBuilder: (context, index) {
              //         var e = state.categories[index];
              //         return SizedBox(
              //           width: 156,
              //           child: Center(
              //             child: CategoryChipItem(
              //               category: e,
              //               isActive: index == state.selectedCategoryIndex,
              //               press: () {
              //                 context.read<CategoryBloc>().add(
              //                     UpdateCategoryIdAndIndex(
              //                         id: e.mainCategoryId!, index: index));
              //                 context.read<SubcategoryBloc>().add(
              //                     FetchSubcategories(
              //                         category: e.mainCategoryId!));
              //                 context
              //                     .read<AllProductsBloc>()
              //                     .add(ClearProductList());
              //                 context
              //                     .read<SubcategoryBloc>()
              //                     .add(UpdateSubCategoryIndex(index: 0));
              //               },
              //             ),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
              // const SizedBox(height: defaultPadding),
              // Text(
              //   "Sub-Categories",
              //   style: Theme.of(context).textTheme.titleSmall,
              // ),
              // const SizedBox(height: defaultPadding / 2),
              // BlocBuilder<SubcategoryBloc, SubcategoryState>(
              //   builder: (context, state) {
              //     return state.loading
              //         ? const SubcategoriesSkeleton()
              //         : SubcatagoriesGridview(
              //             subcategories: state.subcategories,
              //             selectedIndex: state.selectedIndex,
              //           );
              //   },
              // ),
              // SizedBox(height: defaultPadding / 2),

              // BlocBuilder<SubcategoryBloc, SubcategoryState>(
              //     builder: (context, state) {
              //   return state.loading
              //       ? const Center(
              //           child: Padding(
              //             padding: EdgeInsets.only(top: defaultPadding * 2),
              //             child: CommonLoader(),
              //           ),
              //         )
              //       : !state.loading && state.subcategories.isEmpty
              //           ? const Center(
              //               child: Padding(
              //                 padding:
              //                     EdgeInsets.only(top: defaultPadding * 2),
              //                 child: Text('No Items !'),
              //               ),
              //             )
              //           : const ProductGridview();
              // })
              ProductGridview(),
            ],
          ),
        ),
      ),
    );
  }
}
