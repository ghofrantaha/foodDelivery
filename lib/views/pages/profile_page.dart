import 'package:flutter/material.dart';
import 'package:foodapp/utilities/media_query_extension.dart';
import 'package:foodapp/views/widgets/profile_item_tile.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../widgets/main_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(AuthController model, context) async {
    try {
      await model.logout();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (_, model, __) => Scaffold(
        appBar: AppBar(title: const Text('My Profile')),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/profile_photo.jpeg',
                        width: context.width * 0.25,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          'Ghufran Taha',
                          style: Theme.of(context).textTheme.headlineMedium!,
                        ),
                        Text(
                          model.auth.currentUser!.email!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black45),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const ProfileItemTile(
                  title: 'My Orders', content: 'Already have 12 orders'),
              const ProfileItemTile(
                  title: 'Shipping Addresses', content: '3 addresses'),
              const ProfileItemTile(
                  title: 'Payment Methods', content: 'Visa **43'),
              const ProfileItemTile(
                  title: 'Promocodes',
                  content: 'You have 2 special promocodes'),
              const ProfileItemTile(
                  title: 'Settings', content: 'Notifications, Password, Help'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: MainButton(
                    text: 'Log Out',
                    onTap: () {
                      _logout(model, context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
