import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/storage_keys.dart';
import '../models/app_user.dart';

/// Thin wrapper over SharedPreferences. Never throws: failures are reported
/// through return values.
class StorageService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  static Future<StorageService> create() async =>
      StorageService(await SharedPreferences.getInstance());

  /// Returns an empty list when nothing is stored or data is corrupted.
  List<AppUser> readUsers() {
    try {
      final raw = _prefs.getString(StorageKeys.users);
      if (raw == null || raw.isEmpty) return [];
      final decoded = jsonDecode(raw);
      if (decoded is! List) return [];
      return decoded.map(AppUser.tryFromJson).whereType<AppUser>().toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> writeUsers(List<AppUser> users) async {
    try {
      final raw = jsonEncode(users.map((u) => u.toJson()).toList());
      return await _prefs.setString(StorageKeys.users, raw);
    } catch (_) {
      return false;
    }
  }

  String? readSessionUserId() {
    try {
      return _prefs.getString(StorageKeys.sessionUserId);
    } catch (_) {
      return null;
    }
  }

  Future<bool> writeSessionUserId(String id) async {
    try {
      return await _prefs.setString(StorageKeys.sessionUserId, id);
    } catch (_) {
      return false;
    }
  }

  Future<bool> clearSession() async {
    try {
      return await _prefs.remove(StorageKeys.sessionUserId);
    } catch (_) {
      return false;
    }
  }
}
