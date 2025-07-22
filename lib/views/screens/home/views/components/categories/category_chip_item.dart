import 'package:crocurry/data/models/category_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CategoryChipItem extends StatelessWidget {
  const CategoryChipItem({
    super.key,
    required this.category,
    required this.isActive,
    required this.press,
    this.homeScreenList = false,
  });

  final bool isActive;
  final bool homeScreenList;
  final VoidCallback press;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        width: homeScreenList ? null : context.screenWidth * 0.5,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
            color:
                isActive ? Colors.transparent : Theme.of(context).dividerColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            // const SizedBox(width: defaultPadding / 2),
            if (homeScreenList)
              Text(
                category.productCategoryName!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyLarge!.color,
                ),
              )
            else
              Expanded(
                child: Text(
                  category.productCategoryName!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isActive
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
