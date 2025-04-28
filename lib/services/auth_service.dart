import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthService {
  Stream<User?> authChanges();
  Future<void> login(String email, String password);
  Future<void> register(String fullName, String email, String password);
  Future<void> logout();
}

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<User?> authChanges() => _auth.authStateChanges();

  @override
  Future<void> login(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> register(String fullName, String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await cred.user?.updateDisplayName(fullName);
  }

  @override
  Future<void> logout() => _auth.signOut();
}