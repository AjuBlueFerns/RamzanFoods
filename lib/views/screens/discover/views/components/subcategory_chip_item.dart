import 'package:crocurry/data/models/subcategory_model.dart';
import 'package:crocurry/utils/constants.dart';
import 'package:flutter/material.dart';

class SubcategoryChipItem extends StatelessWidget {
  const SubcategoryChipItem({
    super.key,
    required this.subCategory,
    required this.isActive,
    required this.press,
  });

  final bool isActive;
  final VoidCallback press;
  final SubcategoryModel subCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            const SizedBox(width: defaultPadding / 2),
            Expanded(
              child: Text(
                subCategory.productCategoryName!,
                maxLines: 3,
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
