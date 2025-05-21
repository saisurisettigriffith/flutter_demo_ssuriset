import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final isLoggedIn = snap.data != null;
        Future.microtask(() => Navigator.pushReplacementNamed(
          context, isLoggedIn ? '/home' : '/login'));
        return const SizedBox.shrink();
      },
    );
  }
}