import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import '../model/response/movies_list_response.dart';
import '../model/response/movies_details_response.dart';
import 'api_constants.dart';
import 'api_endpoints.dart';

class ApiManager {
  static const _timeout = Duration(seconds: 10);

  static Future<MoviesListResponse> getMoviesList() async {
    final url = Uri.https(ApiConstants.baseUrl, EndPoints.moviesListApi);
    try {
      final response = await http.get(url).timeout(_timeout);
      if (response.statusCode != 200) throw HttpException("Server error");

      final json = jsonDecode(response.body);
      return MoviesListResponse.fromJson(json);
    } catch (e) {
      print("⚠️ Fallback → mock movies: $e");
      return _loadMockMovies();
    }
  }

  static Future<MoviesDetailsResponse> getMovieDetails(int movieID) async {
    final url = Uri.https(ApiConstants.baseUrl, EndPoints.movieDetailsApi, {
      "movie_id": movieID.toString(),
      "with_images": "true",
      "with_cast": "true",
    });

    try {
      final response = await http.get(url).timeout(_timeout);
      if (response.statusCode != 200) throw HttpException("Server error");

      final json = jsonDecode(response.body);
      return MoviesDetailsResponse.fromJson(json);
    } catch (e) {
      print("⚠️ Fallback → mock movie details: $e");
      return _loadMockMovieDetails();
    }
  }

  /// ✅ Offline fallbacks
  static Future<MoviesListResponse> _loadMockMovies() async {
    final data = await rootBundle.loadString('assets/mock/mock_movies.json');
    return MoviesListResponse.fromJson(jsonDecode(data));
  }

  static Future<MoviesDetailsResponse> _loadMockMovieDetails() async {
    final data =
    await rootBundle.loadString('assets/mock/mock_movie_details.json');
    return MoviesDetailsResponse.fromJson(jsonDecode(data));
  }
}
