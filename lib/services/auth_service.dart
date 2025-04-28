import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract interface class AuthService {
  Stream<User?> authChanges();
  Future<void> login(String email, String password);
  Future<void> register(String name, String email, String password);
  Future<void> logout();
  Future<String> fetchDisplayName(User user);
}

class FirebaseAuthService implements AuthService {
  final _auth = FirebaseAuth.instance;
  final _db   = FirebaseFirestore.instance;

  @override
  Stream<User?> authChanges() => _auth.authStateChanges();

  @override
  Future<void> login(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> register(String name, String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await cred.user!.updateDisplayName(name);
    _db
      .collection('users')
      .doc(cred.user!.uid)
      .set({'displayName': name})
      .catchError((e) => debugPrint('Firestore write failed: $e'));
  }
  @override
  Future<void> logout() => _auth.signOut();
  @override
  Future<String> fetchDisplayName(User user) async {
    final authName = user.displayName;
    if (authName?.isNotEmpty == true) return authName!;
    final doc = await _db.collection('users').doc(user.uid).get();
    final stored = doc.data()?['displayName'] as String?;
    if (stored?.isNotEmpty == true) return stored!;
    return user.email ?? 'User';
  }
}