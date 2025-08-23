import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/data/model/response/movies_list_response.dart';

import 'package:movie_app/data/services/api_endpoints.dart';

import 'api_constants.dart';

class ApiManager {
  static Future<MoviesListResponse> getMoviesList() async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.moviesListApi,
    );
    try {
      var response = await http.get(url);
      var responseBody = response.body;


      ///String
      /// todo:String => Json
      var json = jsonDecode(responseBody);

      print(json);
      /// todo:Json => Object
      return MoviesListResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}