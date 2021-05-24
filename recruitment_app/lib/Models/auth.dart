import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Auth extends ChangeNotifier {
  FirebaseAuth _firebaseAuth;
  AuthResult get authResult {
    return _authResult;
  }

  AuthResult _authResult;

  final String email;
  final String passoword;
  final String user;

  Auth({
    this.email,
    this.passoword,
    this.user,
  });

  Future<void> registerWithEmailAndPassword(Auth auth) async {
    try {
      _firebaseAuth = FirebaseAuth.instance;
      _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: auth.email,
        password: auth.passoword,
      );
      if (_authResult != null) {
        notifyListeners();
      }
    } on PlatformException catch (e) {
      throw e.message;
    }
  }

  Future<void> signInWithEmailAndPassword(Auth auth) async {
    try {
      _firebaseAuth = FirebaseAuth.instance;
      _authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: auth.email,
        password: auth.passoword,
      );
    } on PlatformException catch (e) {
      throw e.message;
    }
  }

  Future<void> authSignOut() async {
    try {
      final currentUser = await FirebaseAuth.instance.currentUser();
      if (currentUser != null) {
        _firebaseAuth = FirebaseAuth.instance;
        await _firebaseAuth.signOut();
      }
    } on PlatformException catch (e) {
      throw e.message;
    }
  }
}
