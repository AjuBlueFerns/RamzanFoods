import 'package:crocurry/utils/constants.dart';
import 'package:crocurry/views/bloc/orders/orders_bloc.dart';
import 'package:crocurry/views/bloc/orders/orders_state.dart';
import 'package:crocurry/views/screens/components/common_loader.dart';
import 'package:crocurry/views/screens/order/views/orders_list_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// listview widget to display the order list
class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
      if (state.isLoading!) {
        return const CommonLoader();
      }
      var orders = state.orders!;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              color: greyColor,
              indent: 0,
              endIndent: 0,
            );
          },
          shrinkWrap: true,
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index];
            return OrdersListItemView(order: order);
          },
        ),
      );
    });
  }
}
