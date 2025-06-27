// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wori_app_frontend/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> getCachedUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearCachedUser();
  Future<String?> getAccessToken();
  Future<void> saveAccessToken(String token);
  Future<void> deleteAccessToken();

  // Refresh token methods (only for mobile, handled by cookies on web)
  Future<void> saveRefreshTokenMobile(String token);
  Future<String?> getRefreshTokenMobile();
  Future<void> deleteRefreshTokenMobile();
}

const CACHED_USER = 'CACHED_USER';
const ACCESS_TOKEN = 'ACCESS_TOKEN';
// REFRESH_TOKEN_MOBILE è solo per mobile, non per web (usiamo i cookie)
const REFRESH_TOKEN_MOBILE = 'REFRESH_TOKEN_MOBILE';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage? secureStorage; // Nullable per web

  AuthLocalDataSourceImpl({
    required this.sharedPreferences,
    this.secureStorage, // Injected come null su web
  });

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(
      CACHED_USER,
      json.encode(user.toJson()),
    );
    // Nota: l'access token viene salvato separatamente
  }

  @override
  Future<void> clearCachedUser() async {
    await sharedPreferences.remove(CACHED_USER);
    await deleteAccessToken();
    if (!kIsWeb) {
      await deleteRefreshTokenMobile();
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString(ACCESS_TOKEN);
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await sharedPreferences.setString(ACCESS_TOKEN, token);
  }

  @override
  Future<void> deleteAccessToken() async {
    await sharedPreferences.remove(ACCESS_TOKEN);
  }

  // Mobile-specific refresh token storage
  @override
  Future<void> saveRefreshTokenMobile(String token) async {
    if (!kIsWeb && secureStorage != null) {
      await secureStorage!.write(key: REFRESH_TOKEN_MOBILE, value: token);
    } else if (kIsWeb) {
      // Refresh token is handled by HTTP-only cookies on web, no need to store here.
      // This method won't be called on web.
    }
  }

  @override
  Future<String?> getRefreshTokenMobile() async {
    if (!kIsWeb && secureStorage != null) {
      return await secureStorage!.read(key: REFRESH_TOKEN_MOBILE);
    }
    return null; // For web, refresh token is in cookie
  }

  @override
  Future<void> deleteRefreshTokenMobile() async {
    if (!kIsWeb && secureStorage != null) {
      await secureStorage!.delete(key: REFRESH_TOKEN_MOBILE);
    }
  }
}
