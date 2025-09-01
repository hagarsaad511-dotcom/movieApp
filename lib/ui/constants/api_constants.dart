class ApiConstants {
  static const String baseUrl = 'https://yts.mx/api';
  static const String authBaseUrl = 'https://your-auth-api.com/api'; // replace with real auth API

  // Movie endpoints
  static const String listMovies = '/v2/list_movies.json';
  static const String movieDetails = '/v2/movie_details.json';
  static const String movieSuggestions = '/v2/movie_suggestions.json';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String resetPassword = '/auth/reset-password';
  static const String profile = '/auth/profile';
}
