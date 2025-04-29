import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/validators.dart';
import '../core/widgets/auth_text_field.dart';
import '../core/widgets/loading_overlay.dart';
import '../view_models/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey   = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final vm = ctx.watch<AuthViewModel>();

    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          // explicitly disable any automatic back arrow
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              AuthTextField(
                label: 'Email',
                controller: _emailCtrl,
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              AuthTextField(
                label: 'Password',
                controller: _passCtrl,
                validator: validatePassword,
                obscure: true,
              ),
              const SizedBox(height: 16),
              if (vm.error != null)
                Text(vm.error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: vm.loading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;
                        await vm.login(
                          _emailCtrl.text.trim(),
                          _passCtrl.text,
                        );
                        if (vm.error == null) {
                          Navigator.pushReplacementNamed(ctx, '/home');
                        }
                      },
                child: vm.loading
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(ctx, '/register'),
                child: const Text("Don't have an account? Register"),
              ),
            ]),
          ),
        ),
      ),
      if (vm.loading) const LoadingOverlay(),
    ]);
  }
}