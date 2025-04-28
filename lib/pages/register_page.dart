import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/validators.dart';
import '../core/widgets/auth_text_field.dart';
import '../core/widgets/loading_overlay.dart';
import '../view_models/auth_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey   = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
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
          title: const Text('Register'),
          leading: BackButton(
            onPressed: () => Navigator.pop(ctx),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              AuthTextField(
                label: 'Full Name',
                controller: _nameCtrl,
                validator: validateName,
              ),
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
                        await vm.register(
                          _nameCtrl.text.trim(),
                          _emailCtrl.text.trim(),
                          _passCtrl.text,
                        );
                        if (vm.error == null) {
                          Navigator.pushReplacementNamed(ctx, '/home');
                        }
                      },
                child: vm.loading
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(ctx, '/login'),
                child: const Text('Already have an account? Login'),
              ),
            ]),
          ),
        ),
      ),
      if (vm.loading) const LoadingOverlay(),
    ]);
  }
}