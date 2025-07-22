import 'package:crocurry/views/screens/order/views/orders_list_view.dart';
import 'package:flutter/material.dart';
/// screen for listing the order history
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: const OrdersListView(),
    );
  }
}
