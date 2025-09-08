class ApiConstants {

  // Movie endpoints
  static const String moviesBaseUrl = 'https://yts.mx/api';
  static const String listMovies = '/list_movies.json';
  static const String movieDetails = '/movie_details.json';
  static const String movieSuggestions = '/movie_suggestions.json';
  // Auth endpoints
  static const String authBaseUrl = 'https://route-movie-apis.vercel.app/';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String resetPassword = '/auth/reset-password';
  static const String profile = '/auth/profile';
  static const String delete = '/auth/delete';
}
