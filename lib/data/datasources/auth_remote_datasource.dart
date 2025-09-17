import 'package:dio/dio.dart';
import '../../ui/core/network/api_service.dart';
import '../models/auth_models.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<RegisterResponse> register(RegisterRequest request);
  Future<void> resetPassword({required String oldPassword, required String newPassword});
  Future<UserModel> updateProfile(UpdateProfileRequest request);
  Future<void> deleteAccount();
  Future<UserModel> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  Never _handleDioError(DioException e, String action) {
    final status = e.response?.statusCode;
    final data = e.response?.data;
    print("❌ $action failed (Status: $status) ↳ $data");

    String message;
    if (data is Map<String, dynamic> && data['message'] != null) {
      message = data['message'];
    } else {
      message = e.message ?? 'Unknown error';
    }

    throw Exception('[$action] $message');
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      return await apiService.login(request);
    } on DioException catch (e) {
      _handleDioError(e, "Login");
    }
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      return await apiService.register(request);
    } on DioException catch (e) {
      _handleDioError(e, "Register");
    }
  }

  @override
  Future<void> resetPassword({required String oldPassword, required String newPassword}) async {
    try {
      return await apiService.resetPassword({"oldPassword": oldPassword, "newPassword": newPassword});
    } on DioException catch (e) {
      _handleDioError(e, "ResetPassword");
    }
  }

  @override
  Future<UserModel> updateProfile(UpdateProfileRequest request) async {
    try {
      return await apiService.updateProfile(request);
    } on DioException catch (e) {
      _handleDioError(e, "UpdateProfile");
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      return await apiService.deleteAccount();
    } on DioException catch (e) {
      _handleDioError(e, "DeleteAccount");
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      return await apiService.getProfile();
    } on DioException catch (e) {
      _handleDioError(e, "GetProfile");
    }
  }
}
