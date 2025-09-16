class ApiConstants {


// Movie endpoints
  static const String moviesBaseUrl = 'https://route-movie-apis.vercel.app';
  static const String listMovies = '/list_movies.json';
  static const String movieDetails = '/movie_details.json';
  static const String movieSuggestions = '/movie_suggestions.json';
// Auth endpoints
  static const String authBaseUrl = 'https://yts.mx/api';
  static const String login = "/auth/login";

  /// POST → /auth/register
  static const String register = "/auth/register";

  /// POST → /auth/forgotPassword (sometimes called resetPassword)
  static const String resetPassword = "auth/reset-password";

  /// PATCH → /auth/profile
  static const String getProfile = "/auth/profile";
  static const String updateProfile = "profile";
  /// DELETE → /auth/delete
  static const String delete = "profile";
}