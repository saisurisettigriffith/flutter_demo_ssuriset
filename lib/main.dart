import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'services/auth_service.dart';
import 'view_models/auth_view_model.dart';
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => FirebaseAuthService(),
      child: ChangeNotifierProvider(
        create: (ctx) => AuthViewModel(ctx.read<AuthService>()),
        child: MaterialApp(
          title: 'Login Firebase',
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/splash',
          routes: {
            '/splash'  : (_) => const SplashPage(),
            '/login'   : (_) => const LoginPage(),
            '/register': (_) => const RegisterPage(),
            '/home'    : (_) => const HomePage(),
          },
        ),
      ),
    );
  }
}