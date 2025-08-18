import '../../ui/core/network/api_service.dart';
import '../models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<RegisterResponse> register(RegisterRequest request);
  Future<void> resetPassword(ResetPasswordRequest request);
  Future<UserModel> updateProfile(UpdateProfileRequest request);
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
  Future<void> resetPassword(ResetPasswordRequest request) async {
    try {
      return await apiService.resetPassword(request);
    } catch (e) {
      throw Exception('Failed to reset password: $e');
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
}
