import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_app/data/models/auth_models.dart';

import '../../constants/api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.authBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Auth endpoints
  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST(ApiConstants.register)
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @PATCH(ApiConstants.resetPassword)
  Future<void> resetPassword(@Body() ForgotPasswordRequest request);

  @PUT(ApiConstants.profile)
  Future<UserModel> updateProfile(@Body() UpdateProfileRequest request);

  /// Delete the current user account
  @DELETE(ApiConstants.delete)
  Future<void> deleteAccount();
}
