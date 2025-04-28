import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _svc;
  AuthViewModel(this._svc);

  bool _loading = false;
  String? _error;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> login(String email, String pw) => _wrap(() => _svc.login(email, pw));
  Future<void> register(String name, String email, String pw) =>
      _wrap(() => _svc.register(name, email, pw));
  Future<void> logout() => _svc.logout();

  Future<void> _wrap(Future<void> Function() op) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await op();
    } on Exception catch (e) {
      _error = _humanize(e);
    }
    _loading = false;
    notifyListeners();
  }

  String _humanize(Object e) {
    final msg = e.toString();
    if (msg.contains('wrong-password')) return 'Wrong password.';
    if (msg.contains('email-already-in-use')) return 'Email already registered.';
    if (msg.contains('user-not-found')) return 'User not found. Register first.';
    return msg;
  }
}