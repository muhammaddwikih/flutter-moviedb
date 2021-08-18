import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/services/movie_service.dart';

final favoriteViewModelProvider =
StateNotifierProvider<FavoriteViewModel, AsyncState<List<MovieDetail>>>(
        (ref) => FavoriteViewModel(ref.read(movieServiceProvider)));

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
