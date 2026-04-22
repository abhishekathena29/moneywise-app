import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/user_data_repository.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._repository, {FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance {
    _authSubscription = _auth!.authStateChanges().listen(_handleAuthChanged);
  }

  AuthProvider.fake()
    : _repository = null,
      _auth = null,
      _authSubscription = null,
      _initialized = true;

  final FirebaseAuth? _auth;
  final UserDataRepository? _repository;

  StreamSubscription<User?>? _authSubscription;
  User? _user;
  bool _initialized = false;
  bool _isBusy = false;
  String? _errorMessage;

  bool get initialized => _initialized;
  bool get isBusy => _isBusy;
  bool get isLoggedIn => _user != null;
  String? get uid => _user?.uid;
  String? get errorMessage => _errorMessage;
  String get userName {
    final displayName = _user?.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }
    final email = _user?.email;
    if (email != null && email.isNotEmpty) {
      return email.split('@').first;
    }
    return 'Alex';
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final auth = _auth;
    if (auth == null) return;
    await _runAuthAction(() async {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await credential.user?.updateDisplayName(name.trim());
      final user = auth.currentUser;
      if (user != null) {
        await _repository?.ensureUserDocument(
          uid: user.uid,
          email: user.email ?? email.trim(),
          name: name.trim(),
        );
        await user.reload();
        _user = auth.currentUser;
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    final auth = _auth;
    if (auth == null) return;
    await _runAuthAction(() async {
      final credential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        await _repository?.ensureUserDocument(
          uid: user.uid,
          email: user.email ?? email.trim(),
          name: user.displayName?.trim().isNotEmpty == true
              ? user.displayName!.trim()
              : email.trim().split('@').first,
        );
      }
    });
  }

  Future<void> signOut() async {
    await _auth?.signOut();
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> _runAuthAction(Future<void> Function() action) async {
    _isBusy = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await action();
    } on FirebaseAuthException catch (error) {
      _errorMessage = _friendlyAuthError(error);
    } catch (_) {
      _errorMessage = 'Something went wrong. Please try again.';
    } finally {
      _isBusy = false;
      notifyListeners();
    }
  }

  Future<void> _handleAuthChanged(User? user) async {
    _user = user;
    _initialized = true;
    notifyListeners();
  }

  String _friendlyAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'That email is already in use.';
      case 'invalid-email':
        return 'Enter a valid email address.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'network-request-failed':
        return 'Network error. Check your connection and try again.';
      default:
        return error.message ?? 'Authentication failed.';
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
