import 'package:crocurry/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({
    super.key,
    required this.isVisible,
    required this.count,
    required this.isSelected,
  });
  final bool isVisible;
  final int count;
  final bool isSelected;
  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  int cartCount = 0;

  @override
  void initState() {
    updateCount();
    super.initState();
  }

  void updateCount() {
    cartCount = widget.count;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant CartIcon oldWidget) {
    if (widget.count != oldWidget.count) {
      updateCount();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Badge.count(
      backgroundColor: context.primaryColor,
      isLabelVisible: widget.isVisible,
      count: cartCount,
      child: SvgPicture.asset(
        "assets/icons/Bag.svg",
        height: 24,
        colorFilter: ColorFilter.mode(
          widget.isSelected
              ? context.primaryColor
              : Theme.of(context).textTheme.bodyLarge!.color!,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
