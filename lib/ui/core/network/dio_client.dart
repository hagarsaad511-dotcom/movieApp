import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/ui/constants/api_constants.dart';

class DioClient {
  static Dio createAuthDio(SharedPreferences prefs) {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.authBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = prefs.getString('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));

    return dio;
  }

}