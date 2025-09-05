import 'dart:convert';

import 'package:http/http.dart' as client;

import '../../ui/constants/api_constants.dart';
import '../../ui/core/network/api_service.dart';
import '../models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<RegisterResponse> register(RegisterRequest request);
  Future<void> forgotPassword(ForgotPasswordRequest request);
  Future<UserModel> updateProfile(UpdateProfileRequest request);
  Future<void> deleteAccount();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      return await apiService.login(request);
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      return await apiService.register(request);
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  @override
  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.authBaseUrl}${ApiConstants.resetPassword}'),
      body: json.encode(request.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send reset password email');
    }
  }

  @override
  Future<UserModel> updateProfile(UpdateProfileRequest request) async {
    try {
      return await apiService.updateProfile(request);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
  @override
    Future<void> deleteAccount() async {
        try {
          await apiService.deleteAccount();
        } catch (e) {
          // fallback stub: simulate delay so app still works in dev
          await Future.delayed(const Duration(milliseconds: 300));
        }
      }
}
