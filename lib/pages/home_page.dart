import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../view_models/auth_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext ctx) {
    final user = FirebaseAuth.instance.currentUser!;
    final svc  = ctx.read<AuthService>();

    return FutureBuilder<String>(
      future: svc.fetchDisplayName(user),
      builder: (_, snap) {
        final name = snap.data ?? user.email ?? 'User';
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Welcome, $name'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    ctx.read<AuthViewModel>().logout();
                    Navigator.pushNamedAndRemoveUntil(
                      ctx, '/login', (r) => false);
                  },
                ),
              ],
            ),
            body: Center(
              child: Text(
                'Hey, $name!\nYou’re successfully logged in.',
                textAlign: TextAlign.center,
                style: Theme.of(ctx).textTheme.headlineSmall,
              ),
            ),
          ),
        );
      },
    );
  }
}