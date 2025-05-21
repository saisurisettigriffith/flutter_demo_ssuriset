import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_demo_ssuriset/pages/home_page.dart';
import 'package:flutter_demo_ssuriset/pages/login_page.dart';
import 'package:flutter_demo_ssuriset/pages/register_page.dart';
import 'package:flutter_demo_ssuriset/pages/splash_page.dart';
import 'package:flutter_demo_ssuriset/services/auth_service.dart';
import 'package:flutter_demo_ssuriset/view_models/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    // If the default app already exists, just ignore
    if (e.code != 'duplicate-app') {
      rethrow;
    }
  }

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