
import 'data/services/api_manager.dart';

void main() async {
  var movies = await ApiManager.getMoviesList();
  print("Movies count: ${movies.data?.movieCount}");
  print("First movie: ${movies.data?.movies?.first.title}");
}
