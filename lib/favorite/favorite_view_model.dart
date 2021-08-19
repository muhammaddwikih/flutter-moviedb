import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/services/movie_service.dart';

final favoriteViewModelProvider =
StateNotifierProvider<FavoriteViewModel, AsyncState<List<MovieDetail>>>(
        (ref) => FavoriteViewModel(ref.read(movieServiceProvider)));

final genreViewModelProvider =
StateNotifierProvider<genreViewModel, String>(
        (ref) => genreViewModel(ref.read(movieServiceProvider)));

class FavoriteViewModel extends StateNotifier<AsyncState<List<MovieDetail>>> {
  final MovieService _movieService;
  FavoriteViewModel(this._movieService) : super(Initial([])) {
  }

  getMovieList() async {
    state = Loading(state.data);
    try {
      var movies = await _movieService.getMovieList();
      state = Success(movies);
    } catch (exception) {
      state = Error('Something went wrong', state.data);
    }
  }

}

class genreViewModel extends StateNotifier<String> {
  final MovieService _movieService;
  genreViewModel(this._movieService) : super("genresss") {
  }

  getGenreList(List<Genre> genre) async {
    try{
      var genres = await _movieService.getGenereList(genre);
      state = genres;
    }catch(exception){
      print(exception);
    }
  }
}
