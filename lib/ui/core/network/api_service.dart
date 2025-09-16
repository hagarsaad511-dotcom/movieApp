import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_app/data/models/auth_models.dart';
import '../../../data/models/user_model.dart';
import '../../constants/api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://route-movie-apis.vercel.app/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST(ApiConstants.register)
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @PATCH("/auth/reset-password")
  Future<void> resetPassword(@Body() Map<String, dynamic> body);

  @GET(ApiConstants.getProfile)
  Future<UserModel> getProfile();

  @PATCH(ApiConstants.updateProfile)
  Future<UserModel> updateProfile(@Body() UpdateProfileRequest request);

  @DELETE(ApiConstants.delete)
  Future<void> deleteAccount();
}
