import 'package:flutter/cupertino.dart';
import 'package:foody/utilities/routes.dart';
import 'package:provider/provider.dart';
import '../controllers/database_controller.dart';
import '../views/pages/button_navbar.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/auth_page.dart';
import '../views/pages/product_details.dart';

Route<dynamic> onGenerate(RouteSettings settings){
  switch(settings.name){
    case AppRoutes.loginPageRoute:
      return  CupertinoPageRoute(builder: (_) =>const AuthPage(), settings:settings);


    case AppRoutes.buttonNavBarRoute:
      return  CupertinoPageRoute(builder: (_) =>const  BottomNavbar(),settings:settings );
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

    case AppRoutes.landingPageRoute:
    default:
      return  CupertinoPageRoute(builder: (_) =>const LandingPage(),settings:settings );


  }
}