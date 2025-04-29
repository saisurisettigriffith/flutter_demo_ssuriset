import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _svc;
  AuthViewModel(this._svc);

  bool   loading = false;
  String? error;

  Future<void> login(String email, String pw)   => _wrap(() => _svc.login(email, pw));
  Future<void> register(String name, String email, String pw)
                                                => _wrap(() => _svc.register(name, email, pw));
  Future<void> logout()                        => _svc.logout();

  Future<void> _wrap(Future<void> Function() op) async {
    loading = true;
    error   = null;
    notifyListeners();

    try {
      await op();
    }
    on FirebaseException catch (e) {
      error = e.message ?? e.code;
    }
    finally {
      loading = false;
      notifyListeners();
    }
  }
}