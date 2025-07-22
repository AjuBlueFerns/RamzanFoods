import 'package:crocurry/utils/custom_toast.dart';
import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AddToWishListIcon extends StatelessWidget {
  const AddToWishListIcon({
    super.key,
    required this.isLoggedIn,
  });
  final bool isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        CustomToast.showInfoMessage(
            context: context, message: 'Login to add to wishlist !');
      },
      icon: Icon(
        Icons.favorite_border_outlined,
        color: context.primaryColor,
      ),
    );
  }
}
