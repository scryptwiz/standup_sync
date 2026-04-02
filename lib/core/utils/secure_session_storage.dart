import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SecureSessionStorage extends LocalStorage {
  static const _storageKey = supabasePersistSessionKey;

  final FlutterSecureStorage _storage;

  SecureSessionStorage({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<void> initialize() async {}

  @override
  Future<void> persistSession(String persistSessionString) async {
    await _storage.write(key: _storageKey, value: persistSessionString);
  }

  @override
  Future<void> removePersistedSession() async {
    await _storage.delete(key: _storageKey);
  }

  @override
  Future<bool> hasAccessToken() async {
    final persistedSession = await _storage.read(key: _storageKey);
    return persistedSession != null && persistedSession.isNotEmpty;
  }

  @override
  Future<String?> accessToken() async {
    final persistedSession = await _storage.read(key: _storageKey);
    if (persistedSession == null || persistedSession.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(persistedSession);
      if (decoded is! Map<String, dynamic>) return null;

      final currentSession = decoded['currentSession'];
      if (currentSession is Map<String, dynamic>) {
        final token = currentSession['access_token'];
        if (token is String) return token;
      }

      final directToken = decoded['access_token'];
      if (directToken is String) return directToken;
    } catch (_) {
      return null;
    }

    return null;
  }
}
