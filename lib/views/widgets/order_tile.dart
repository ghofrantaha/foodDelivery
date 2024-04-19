import 'package:flutter/material.dart';
import 'package:foodapp/models/order_data.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.orange.shade800,
        child: const Icon(
          Icons.shopping_basket_outlined,
          color: Colors.white60,
        ),
      ),
      isThreeLine: true,
      title: Text(
        order.code,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            order.status,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            DateFormat('dd/MM/yyyy').format(order.orderTime),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      trailing: Text(
        '${order.total} EGP',
        style: const TextStyle(
          fontSize: 18,
          color: Colors.green,
        ),
      ),
    );
  }
}
