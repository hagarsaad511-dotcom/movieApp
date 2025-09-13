import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/ui/constants/api_constants.dart';

class DioClient {
  final Dio _dio;
  final SharedPreferences _preferences;

  DioClient(this._dio, this._preferences) {
    _dio
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.responseType = ResponseType.json;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _preferences.getString('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            _preferences.remove('auth_token');
            _preferences.remove('user_data');
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}