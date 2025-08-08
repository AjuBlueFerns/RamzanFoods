import 'package:crocurry/domain/use_cases/product/get_categories.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/locator.dart';
import 'package:crocurry/views/bloc/categories/category_bloc.dart';
import 'package:crocurry/views/bloc/categories/category_event.dart';
import 'package:crocurry/views/bloc/filter/filter_bloc.dart';
import 'package:crocurry/views/bloc/filter/filter_event.dart';
import 'package:crocurry/views/screens/components/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySkeleton extends StatefulWidget {
  const CategorySkeleton({
    super.key,
  });

  @override
  State<CategorySkeleton> createState() => _CategorySkeletonState();
}

class _CategorySkeletonState extends State<CategorySkeleton> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      updateCategories(context);
    });
    super.initState();
  }

  updateCategories(BuildContext context) async {
    final details = await locator<GetProductCategories>().call();
    var list = details.$1 ?? [];
    if (context.mounted) {
      context.read<CategoryBloc>().add(FetchCategories(list));
      context.read<FilterBloc>().add(InitCategoryFilter(list));
    }
  }

  // final String category;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: LoadingShimmer.rectangle(
          height: 10,
          width: 45,
        ),
      ),
    );
  }
}
