import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../view_models/auth_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return WillPopScope(
      onWillPop: () async => false, // disable hardware back
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,   // ← hides back arrow
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),  // default white icon
              onPressed: () async {
                await context.read<AuthViewModel>().logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/landing',
                  (route) => false,
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Text(
            "Hey, ${user.displayName ?? user.email}! You’re successfully logged in.",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}