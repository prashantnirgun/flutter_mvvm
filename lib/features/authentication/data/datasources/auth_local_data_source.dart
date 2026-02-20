import 'dart:convert';

import 'package:bpp/core/constants/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> saveUser(Map<String, dynamic> userJson);
  Future<String> getToken();
  Future<Map<String, dynamic>?> getUser();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl();

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.TOKENKEY, token);
  }

  @override
  Future<void> saveUser(Map<String, dynamic> userJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.USERDATAKEY, jsonEncode(userJson));
  }

  @override
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.TOKENKEY) ?? '';
  }

  @override
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(AppConstants.USERDATAKEY);
    if (s == null) return null;
    try {
      return Map<String, dynamic>.from(jsonDecode(s));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.TOKENKEY);
    await prefs.remove(AppConstants.USERDATAKEY);
  }
}
