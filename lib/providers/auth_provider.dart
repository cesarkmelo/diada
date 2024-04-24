import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthState with ChangeNotifier {
  AuthState() {
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _uid = user.uid;
        _uname = user.displayName!;
        _isAuth = true;
      } else {
        _isAuth = false;
      }
      notifyListeners();
    });
  }

  String _email = '';
  String get email => _email;

  String _uid = '';
  String get uid => _uid;

  String _uname = '';
  String get uname => _uname;

  bool _isAuth = false;
  bool get isAuth => _isAuth;

  Future<String> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
      _isAuth = true;
      _uid = credential.user!.uid;
      _uname = displayName;
      _email = email;
      notifyListeners();
      return _uid;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    return '0';
  }

  Future<String> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _isAuth = true;
      _uid = result.user!.uid;
      _uname = result.user!.displayName!;
      _email = email;
      notifyListeners();
      return _uid;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    return '0';
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
