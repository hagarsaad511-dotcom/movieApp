import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_models.dart';
import '../models/user_model.dart';

abstract class LocalDataSource {
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> removeAuthToken();

  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> removeUser();

  Future<void> clearAuthData();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  LocalDataSourceImpl(this.sharedPreferences);

  static const String _seenOnboardingKey = 'seen_onboarding';
  static const String _authTokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  Future<void> setSeenOnboarding() async {
    await sharedPreferences.setBool(_seenOnboardingKey, true);
  }

  Future<bool> hasSeenOnboarding() async {
    return sharedPreferences.getBool(_seenOnboardingKey) ?? false;
  }

  @override
  Future<void> saveAuthToken(String token) async {
    await sharedPreferences.setString(_authTokenKey, token);
  }

  @override
  Future<String?> getAuthToken() async {
    return sharedPreferences.getString(_authTokenKey);
  }

  @override
  Future<void> removeAuthToken() async {
    await sharedPreferences.remove(_authTokenKey);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await sharedPreferences.setString(_userKey, json.encode(user.toJson()));
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = sharedPreferences.getString(_userKey);
    if (userJson == null) return null;
    return UserModel.fromJson(json.decode(userJson));
  }

  @override
  Future<void> removeUser() async {
    await sharedPreferences.remove(_userKey);
  }

  @override
  Future<void> clearAuthData() async {
    await removeAuthToken();
    await removeUser();
  }
}
