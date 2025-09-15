import 'package:movie_app/data/model/response/movies_list_response.dart';

abstract class HomeScreenStates{}

class HomeScreenLoadingState extends HomeScreenStates{}
class HomeScreenErrorState extends HomeScreenStates {
  String errorMessage;
  HomeScreenErrorState({required this.errorMessage});
}
class HomeScreenSuccessState extends HomeScreenStates {
  List<Movies> movies;
  HomeScreenSuccessState({required this.movies});

}