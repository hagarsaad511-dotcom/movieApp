import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_app/data/models/auth_models.dart';
import 'package:movie_app/data/models/movie_models.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Auth endpoints
  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @PATCH('/auth/reset-password')
  Future<void> resetPassword(@Body() ResetPasswordRequest request);

  @PUT('/auth/profile')
  Future<UserModel> updateProfile(@Body() UpdateProfileRequest request);

  // Movies endpoints
  @GET('/v2/list_movies.json')
  Future<MoviesResponse> getMovies({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('query_term') String? searchTerm,
    @Query('genre') String? genre,
  });

  @GET('/v2/movie_details.json')
  Future<MovieDetailsResponse> getMovieDetails({
    @Query('movie_id') required int movieId,
  });

  @GET('/v2/movie_suggestions.json')
  Future<MoviesResponse> getMovieSuggestions({
    @Query('movie_id') required int movieId,
  });

  // Favorites
  @GET('/favorites')
  Future<List<MovieModel>> getFavorites();

  @POST('/favorites')
  Future<void> addToFavorites(@Body() Map<String, dynamic> movieData);

  @DELETE('/favorites/{movieId}')
  Future<void> removeFromFavorites(@Path('movieId') int movieId);
}
