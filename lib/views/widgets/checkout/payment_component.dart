import 'package:flutter/material.dart';


import '../../../utilities/assets.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.network(
              AppAssets.mastercardIcon,
              fit: BoxFit.cover,
              height: 30,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        const Text('**** **** **** 2718'),
      ],
    );
  }
}