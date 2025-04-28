import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // pop back to landing
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) =>
                    (v != null && v.trim().isNotEmpty) ? null : 'Enter your name',
              ),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) =>
                    (v != null && v.contains('@')) ? null : 'Enter valid email',
              ),
              TextFormField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) =>
                    (v != null && v.length >= 6) ? null : 'Min 6 chars',
              ),
              const SizedBox(height: 16),
              if (vm.error != null)
                Text(vm.error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: vm.loading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          await vm.register(
                            _nameCtrl.text.trim(),
                            _emailCtrl.text.trim(),
                            _passCtrl.text,
                          );
                          if (vm.error == null) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        }
                      },
                child: vm.loading
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/login'),
                child: const Text('Already have an account? Login'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}