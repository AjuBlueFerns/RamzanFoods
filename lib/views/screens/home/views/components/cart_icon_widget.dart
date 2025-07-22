import 'package:crocurry/utils/route/route_constants.dart';
import 'package:crocurry/views/bloc/cart/cart_bloc.dart';
import 'package:crocurry/views/bloc/cart/cart_event.dart';
import 'package:crocurry/views/bloc/cart/cart_state.dart';
import 'package:crocurry/views/screens/home/views/components/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIconWidget extends StatefulWidget {
  const CartIconWidget({
    super.key,
     this.isSelected = false,
  });
  final bool isSelected;
  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartBloc>().add(FetchAndUpdateCartdetails());
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        var condition = (state.cartCount != null && state.cartCount! > 0);
        debugPrint(
            "### cartCount ${state.cartCount} condition :$condition :");
        return CartIcon(
          isVisible: condition,
          count: state.cartCount!,
          isSelected: widget.isSelected,
        );
      },
    );
    // icon: Badge.count(
    //   backgroundColor: context.primaryColor,
    //   isLabelVisible: state.cart != null &&
    //       state.cart!.items != null &&
    //       state.cart!.items!.isNotEmpty,
    //   count: (state.cart == null || state.cart!.items == null)
    //       ? 0
    //       : state.cart!.items!.length,
    //   child: SvgPicture.asset(
    //     "assets/icons/Bag.svg",
    //     height: 24,
    //     colorFilter: ColorFilter.mode(
    //         Theme.of(context).textTheme.bodyLarge!.color!,
    //         BlendMode.srcIn),
    //   ),
    // ));
  }
}
