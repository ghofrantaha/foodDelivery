import 'package:flutter/material.dart';


import '../order_summary_component.dart';

class CheckoutOrderDetails extends StatelessWidget {
  const CheckoutOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OrderSummaryComponent(title: 'Order', value: '125\$'),
        SizedBox(height: 8.0),
        OrderSummaryComponent(title: 'Delivery', value: '15\$'),
        SizedBox(height: 8.0),
        OrderSummaryComponent(title: 'Summary', value: '140\$'),
      ],
    );
  }
}