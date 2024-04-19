import 'package:flutter/cupertino.dart';
import 'package:foodapp/utilities/routes.dart';
import 'package:foodapp/views/pages/orders_page.dart';
import 'package:provider/provider.dart';

import '../controllers/database_controller.dart';
import '../views/pages/auth_page.dart';
import '../views/pages/button_navbar.dart';
import '../views/pages/checkout/add_shipping_address_page.dart';
import '../views/pages/checkout/checkout.dart';
import '../views/pages/checkout/payment_methods_page.dart';
import '../views/pages/checkout/shipping_addresses_page.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/product_details.dart';
import 'args_models/add_shipping_address_args.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
          builder: (_) => const AuthPage(), settings: settings);
    case AppRoutes.ordersRoute:
      return CupertinoPageRoute(builder: (_) => const OrdersPage(), settings: settings);
    case AppRoutes.buttonNavBarRoute:
      return CupertinoPageRoute(
          builder: (_) => const BottomNavbar(), settings: settings);
    case AppRoutes.productDetailsRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: ProductDetails(product: product),
        ),
        settings: settings,
      );
    case AppRoutes.checkoutPageRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
            value: database, child: const CheckoutPage()),
        settings: settings,
      );
    case AppRoutes.shippingAddressesRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const ShippingAddressesPage(),
        ),
        settings: settings,
      );
    case AppRoutes.paymentMethodsRoute:
      return CupertinoPageRoute(
        builder: (_) => const PaymentMethodsPage(),
        settings: settings,
      );
    case AppRoutes.addShippingAddressRoute:
      final args = settings.arguments as AddShippingAddressArgs;
      final database = args.database;
      final shippingAddress = args.shippingAddress;

      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: AddShippingAddressPage(
            shippingAddress: shippingAddress,
          ),
        ),
        settings: settings,
      );
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
          builder: (_) => const LandingPage(), settings: settings);
  }
}
