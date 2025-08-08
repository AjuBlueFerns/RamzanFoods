import 'package:crocurry/data/models/product_model.dart';
import 'package:crocurry/utils/common_functions.dart';
import 'package:crocurry/utils/extensions/string_extensions.dart';
import 'package:crocurry/utils/helper.dart';
import 'package:crocurry/views/screens/home/views/components/products/product_card.dart';
import 'package:flutter/material.dart';

class ProductListview extends StatelessWidget {
  const ProductListview({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      separatorBuilder: (context, index) => Helper.allowHeight(10),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // scrollDirection: Axis.horizontal,
      // itemCount: min(products.length, 5),
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        return ProductCard(
          productModel: product,
          stock: product.qtyInStock!,
          image: product.imagePath!,
          brandName: product.mainCategory!,
          title: product.customTitle!,
          price: product.productMrp!.toDouble(),
          priceAfterDiscount: product.discountedPrice!.toDouble(),
          discountpercent: product.offerDiscountPercent!.toDouble(),
          press: () async {
            CommonFunctions.navigateToProductDetails(context, product);
          },
        );
      },
    );
  }
}
