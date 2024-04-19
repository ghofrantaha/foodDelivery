import 'package:flutter/material.dart';
import 'package:foodapp/models/order_data.dart';
import 'package:foodapp/views/widgets/order_tile.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: orders.length,
        itemBuilder: (context, index) => OrderTile(order: orders[index]),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
