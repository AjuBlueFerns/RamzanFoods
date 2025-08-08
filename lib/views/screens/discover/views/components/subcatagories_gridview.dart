import 'package:crocurry/data/models/subcategory_model.dart';
import 'package:crocurry/views/bloc/all_products/all_products_bloc.dart';
import 'package:crocurry/views/bloc/all_products/all_products_event.dart';
import 'package:crocurry/views/bloc/subcategories/subcategory_bloc.dart';
import 'package:crocurry/views/bloc/subcategories/subcategory_event.dart';
import 'package:crocurry/views/screens/discover/views/components/subcategory_chip_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcatagoriesGridview extends StatefulWidget {
  const SubcatagoriesGridview({
    super.key,
    required this.subcategories,
    required this.selectedIndex,
    // required this.categoryId,
  });
  final List<SubcategoryModel> subcategories;
  final int selectedIndex;
  // final String categoryId;
  @override
  State<SubcatagoriesGridview> createState() => _SubcatagoriesGridviewState();
}

class _SubcatagoriesGridviewState extends State<SubcatagoriesGridview> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.subcategories.isNotEmpty) {
        context.read<AllProductsBloc>().add(FetchAllProducts(
              categoryId: widget.subcategories.first.categoryId,
              subCategoryId: widget.subcategories.first.prodCategoryId!,
              pageNumber: '1',
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: widget.subcategories.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var subcategory = widget.subcategories[index];
        return SizedBox(
          width: 165,
          child: Center(
            child: SubcategoryChipItem(
              subCategory: subcategory,
              isActive: index == widget.selectedIndex,
              press: () {
                context
                    .read<SubcategoryBloc>()
                    .add(UpdateSubCategoryIndex(index: index));
                // context.read<AllProductsBloc>().add(ClearProductList());
                context.read<AllProductsBloc>().add(FetchAllProducts(
                  clearProducts: true,
                      categoryId: subcategory.categoryId!,
                      subCategoryId: subcategory.prodCategoryId!,
                      pageNumber: '1',
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
