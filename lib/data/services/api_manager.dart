import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/data/model/response/movies_list_response.dart';

import 'package:movie_app/data/services/api_endpoints.dart';

import '../model/response/movies_details_response.dart';
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


      /// todo:Json => Object
      return MoviesListResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesDetailsResponse> getMovieDetails(int movieID) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.movieDetailsApi,
        {
       "movie_id": movieID.toString(),
       "with_images": "true",
          "with_cast": "true"
        }

    );
    try {
      var response = await http.get(url);
      var responseBody = response.body;


      ///String
      /// todo:String => Json
      var json = jsonDecode(responseBody);


      /// todo:Json => Object
      return MoviesDetailsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}