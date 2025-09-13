// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/auth_models.dart';
//
//
// abstract class LocalDataSource {
//   Future<void> saveAuthToken(String token);
//   Future<String?> getAuthToken();
//   Future<void> removeAuthToken();
//
//   Future<void> saveUser(UserModel user);
//   Future<UserModel?> getUser();
//   Future<void> removeUser();
//
// }
//
// class LocalDataSourceImpl implements LocalDataSource {
//   final SharedPreferences sharedPreferences;
//
//   LocalDataSourceImpl(this.sharedPreferences);
//
//   static const String _authTokenKey = 'auth_token';
//   static const String _userKey = 'user_data';
//   static const String _favoritesKey = 'favorite_movies';
//   static const String _historyKey = 'watch_history';
//   static const String _cachedMoviesKey = 'cached_movies';
//
//   @override
//   Future<void> saveAuthToken(String token) async {
//     await sharedPreferences.setString(_authTokenKey, token);
//   }
//
//   @override
//   Future<String?> getAuthToken() async {
//     return sharedPreferences.getString(_authTokenKey);
//   }
//
//   @override
//   Future<void> removeAuthToken() async {
//     await sharedPreferences.remove(_authTokenKey);
//   }
//
//   @override
//   Future<void> saveUser(UserModel user) async {
//     final userJson = json.encode(user.toJson());
//     await sharedPreferences.setString(_userKey, userJson);
//   }
//
//   @override
//   Future<UserModel?> getUser() async {
//     final userJson = sharedPreferences.getString(_userKey);
//     if (userJson != null) {
//       final userMap = json.decode(userJson) as Map<String, dynamic>;
//       return UserModel.fromJson(userMap);
//     }
//     return null;
//   }
//
//   @override
//   Future<void> removeUser() async {
//     await sharedPreferences.remove(_userKey);
//   }
// }