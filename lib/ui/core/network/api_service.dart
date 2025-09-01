import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_app/data/models/auth_models.dart';


part 'api_service.g.dart';

@RestApi(baseUrl: "https://your-auth-api.com/api")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Auth endpoints
  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @PATCH('/auth/reset-password')
  Future<void> resetPassword(@Body() ForgotPasswordRequest request);

  @PUT('/auth/profile')
  Future<UserModel> updateProfile(@Body() UpdateProfileRequest request);

}
