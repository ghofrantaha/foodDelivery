import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/database_controller.dart';
import '../../../models/delivery_method.dart';
import '../../../models/shipping_address.dart';
import '../../../utilities/args_models/add_shipping_address_args.dart';
import '../../../utilities/routes.dart';
import '../../widgets/checkout/checkout_order_details.dart';
import '../../widgets/checkout/delivery_method_item.dart';
import '../../widgets/checkout/payment_component.dart';
import '../../widgets/checkout/shipping_address_component.dart';
import '../../widgets/main_button.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping address',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              StreamBuilder<List<ShippingAddress>>(
                  stream: database.getShippingAddresses(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final shippingAddresses = snapshot.data;
                      if (shippingAddresses == null ||
                          shippingAddresses.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const Text('No Shipping Addresses!'),
                              const SizedBox(height: 6.0),
                              InkWell(
                                onTap: () => Navigator.of(context).pushNamed(
                                  AppRoutes.addShippingAddressRoute,
                                  arguments: AddShippingAddressArgs(
                                      database: database),
                                ),
                                child: Text(
                                  'Add new one',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Colors.redAccent,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      // TODO: We need to filter the data to chosse the default one only
                      final shippingAddress = shippingAddresses.first;
                      return ShippingAddressComponent(
                          shippingAddress: shippingAddress);
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.paymentMethodsRoute);
                    },
                    child: Text(
                      'Change',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.redAccent,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const PaymentComponent(),
              const SizedBox(height: 24.0),
              Text(
                'Delivery method',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              StreamBuilder<List<DeliveryMethod>>(
                  stream: database.deliveryMethodsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final deliveryMethods = snapshot.data;
                      if (deliveryMethods == null || deliveryMethods.isEmpty) {
                        return const Center(
                          child: Text('No delivery methods available!'),
                        );
                      }
                      return SizedBox(
                        height: size.height * 0.13,
                        child: ListView.builder(
                          itemCount: deliveryMethods.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DeliveryMethodItem(
                                deliveryMethod: deliveryMethods[i]),
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
              const SizedBox(height: 32.0),
              const CheckoutOrderDetails(),
              const SizedBox(height: 64.0),
              MainButton(
                text: 'Submit Order',
                onTap: () {},
                hasCircularBorder: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
