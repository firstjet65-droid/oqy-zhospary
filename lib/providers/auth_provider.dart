import 'package:flutter/foundation.dart';

import '../l10n/kk_strings.dart';
import '../models/app_user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._service);

  final AuthService _service;

  AppUser? _user;
  bool _initialized = false;
  bool _loading = false;

  AppUser? get user => _user;
  bool get isLoggedIn => _user != null;

  /// True once the splash flow has finished restoring the session.
  bool get initialized => _initialized;
  bool get isLoading => _loading;

  /// Restores the saved session; keeps the splash on screen for [minDuration].
  Future<void> bootstrap({
    Duration minDuration = const Duration(seconds: 2),
  }) async {
    final results = await Future.wait<Object?>([
      _service.restoreSession(),
      Future<void>.delayed(minDuration),
    ]);
    _user = results.first as AppUser?;
    _initialized = true;
    notifyListeners();
  }

  /// Returns an error text in Kazakh, or null on success.
  Future<String?> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    final result = await _service.register(
      fullName: fullName,
      email: email,
      password: password,
    );
    _loading = false;
    if (result.isSuccess) {
      _user = result.user;
      notifyListeners();
      return null;
    }
    notifyListeners();
    return _errorText(result.error);
  }

  /// Returns an error text in Kazakh, or null on success.
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    final result = await _service.login(email: email, password: password);
    _loading = false;
    if (result.isSuccess) {
      _user = result.user;
      notifyListeners();
      return null;
    }
    notifyListeners();
    return _errorText(result.error);
  }

  Future<void> logout() async {
    await _service.logout();
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _errorText(AuthError? error) {
    switch (error) {
      case AuthError.emailTaken:
        return KkStrings.errEmailTaken;
      case AuthError.invalidCredentials:
        return KkStrings.errInvalidCredentials;
      case AuthError.storage:
      case null:
        return KkStrings.unknownError;
    }
  }
}
