import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/controllers/auth_controller.dart';
import 'package:foody/views/pages/auth_page.dart';
import 'package:foody/views/pages/button_navbar.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../services/auth.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return ChangeNotifierProvider<AuthController>(
                create: (_) => AuthController(auth: auth),
                child: const AuthPage(),
              );
            }
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: Provider<Database>(
                  create: (_) => FirestoreDatabase(user.uid),
                  child: const BottomNavbar()),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
