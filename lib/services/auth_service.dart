import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import '../models/app_user.dart';
import 'storage_service.dart';

enum AuthError { emailTaken, invalidCredentials, storage }

/// Typed result: either a user or an error.
class AuthResult {
  const AuthResult.success(AppUser this.user) : error = null;
  const AuthResult.failure(AuthError this.error) : user = null;

  final AppUser? user;
  final AuthError? error;

  bool get isSuccess => user != null;
}

class AuthService {
  AuthService(this._storage);

  final StorageService _storage;

  static String hashPassword(String password, String salt) =>
      sha256.convert(utf8.encode(salt + password)).toString();

  static String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  Future<AuthResult> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final normalized = email.trim().toLowerCase();
    final users = _storage.readUsers();
    if (users.any((u) => u.email == normalized)) {
      return const AuthResult.failure(AuthError.emailTaken);
    }

    final salt = _generateSalt();
    final now = DateTime.now();
    final user = AppUser(
      id: '${now.microsecondsSinceEpoch}',
      fullName: fullName.trim(),
      email: normalized,
      passwordHash: hashPassword(password, salt),
      salt: salt,
      createdAt: now,
    );

    final saved = await _storage.writeUsers([...users, user]);
    if (!saved) return const AuthResult.failure(AuthError.storage);
    final session = await _storage.writeSessionUserId(user.id);
    if (!session) return const AuthResult.failure(AuthError.storage);
    return AuthResult.success(user);
  }

  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final normalized = email.trim().toLowerCase();
    final matches = _storage
        .readUsers()
        .where((u) => u.email == normalized)
        .toList();
    if (matches.isEmpty) {
      return const AuthResult.failure(AuthError.invalidCredentials);
    }
    final user = matches.first;
    if (hashPassword(password, user.salt) != user.passwordHash) {
      return const AuthResult.failure(AuthError.invalidCredentials);
    }
    final session = await _storage.writeSessionUserId(user.id);
    if (!session) return const AuthResult.failure(AuthError.storage);
    return AuthResult.success(user);
  }

  /// Returns the saved user, or null (clearing a stale session id).
  Future<AppUser?> restoreSession() async {
    final id = _storage.readSessionUserId();
    if (id == null) return null;
    for (final user in _storage.readUsers()) {
      if (user.id == id) return user;
    }
    await _storage.clearSession();
    return null;
  }

  Future<void> logout() async {
    await _storage.clearSession();
  }
}
