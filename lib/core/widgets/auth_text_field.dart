import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.obscure = false,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool obscure;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final _show = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _show,
      builder: (_, bool visible, __) => TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscure && !visible,
        decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: widget.obscure
              ? IconButton(
                  icon: Icon(visible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => _show.value = !visible,
                )
              : null,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}