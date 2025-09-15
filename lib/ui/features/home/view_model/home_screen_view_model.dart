import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/services/api_manager.dart';
import 'package:movie_app/ui/features/home/cubit/home_screen_states.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  HomeScreenViewModel() :super(HomeScreenLoadingState());

  Future<void> getMoviesList() async {
    try {
      ///todo: loading
      emit(HomeScreenLoadingState());
      var response = await ApiManager.getMoviesList();
      if (response.status == 'error') {
        ///todo: server => error
        emit(HomeScreenErrorState(errorMessage: response.statusMessage!));
      }
      if (response.status == 'ok') {
        ///todo: server => success
        emit(HomeScreenSuccessState(movies: response.data!.movies!));
      }
    } catch (e) {
      ///todo: server => client
      emit(HomeScreenErrorState(errorMessage: e.toString()));
    }
  }

}