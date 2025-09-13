import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/ui/constants/api_constants.dart';

class DioClient {
  static Dio createAuthDio(SharedPreferences prefs) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.authBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          if (status == null) return false;
          return status < 400;
        },
      ),
    );

    // 🔎 Log requests and responses
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        logPrint: (obj) {
          // Pretty-print JSON if possible
          if (obj is String && obj.startsWith('{')) {
            try {
              final pretty = const JsonEncoder.withIndent('  ')
                  .convert(jsonDecode(obj));
              print("🌐 $pretty");
              return;
            } catch (_) {}
          }
          print("🌐 $obj");
        },
      ),
    );

    // 🔑 Automatically attach auth token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = prefs.getString('auth_token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            print("🔑 Using token: ${token.substring(0, 10)}...");
          }
          handler.next(options);
        },
      ),
    );

    return dio;
  }
}
