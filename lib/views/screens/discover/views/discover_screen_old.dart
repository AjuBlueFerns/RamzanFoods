import 'package:crocurry/data/models/category_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/all_products/all_products_bloc.dart';
import 'package:crocurry/views/bloc/all_products/all_products_event.dart';
import 'package:crocurry/views/bloc/categories/category_bloc.dart';
import 'package:crocurry/views/bloc/categories/category_state.dart';
import 'package:crocurry/views/bloc/subcategories/subcategory_bloc.dart';
import 'package:crocurry/views/bloc/subcategories/subcategory_event.dart';
import 'package:crocurry/views/bloc/subcategories/subcategory_state.dart';
import 'package:crocurry/views/screens/components/common_loader.dart';
import 'package:crocurry/views/screens/discover/views/components/product_gridview.dart';
import 'package:crocurry/views/screens/discover/views/components/subcatagories_gridview.dart';
import 'package:crocurry/views/screens/discover/views/components/subcategories_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverScreen2 extends StatelessWidget {
  const DiscoverScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Padding(
                //   padding: EdgeInsets.symmetric(vertical: defaultPadding),
                //   child: SearchForm(),
                // ),
                const SizedBox(height: defaultPadding / 2),
                Text(
                  "Categories",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: defaultPadding / 2),
                BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                  return Container(
                    height: 42,
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(defaultBorderRadius),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: false,
                        items: state.categories.map<DropdownMenuItem<String>>(
                            (CategoryModel category) {
                          return DropdownMenuItem<String>(
                            value: category.mainCategoryId!,
                            child: Text(
                              category.productCategoryName!.trim(),
                              style:  Theme.of(context).textTheme.titleSmall,
                            ),
                          );
                        }).toList(),
                        value: state.selectedCategoryId,
                        onChanged: (String? categoryId) {
                         
                        
                          context
                              .read<AllProductsBloc>()
                              .add(ClearProductList());
                          context
                              .read<SubcategoryBloc>()
                              .add(UpdateSubCategoryIndex(index: 0));
                        },
                      ),
                    ),
                  );
                }),
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
                const SizedBox(height: defaultPadding),
                Text(
                  "Sub-Categories",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: defaultPadding / 2),
                BlocBuilder<SubcategoryBloc, SubcategoryState>(
                  builder: (context, state) {
                    return state.loading
                        ? const SubcategoriesSkeleton()
                        : SubcatagoriesGridview(
                            subcategories: state.subcategories,
                            selectedIndex: state.selectedIndex,
                          );
                  },
                ),
                const SizedBox(height: defaultPadding / 2),

                BlocBuilder<SubcategoryBloc, SubcategoryState>(
                    builder: (context, state) {
                  return state.loading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: defaultPadding * 2),
                            child: CommonLoader(),
                          ),
                        )
                      : !state.loading && state.subcategories.isEmpty
                          ? const Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: defaultPadding * 2),
                                child: Text('No Items !'),
                              ),
                            )
                          : const ProductGridview();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
