import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/services/movie_service.dart';

final detailMoviesViewModelProvider =
StateNotifierProvider<DetailMoviesViewModel, AsyncState<List<MovieDetail>>>(
        (ref) => DetailMoviesViewModel(ref.read(movieServiceProvider)));

class DetailMoviesViewModel extends StateNotifier<AsyncState<List<MovieDetail>>> {
  final MovieService _movieService;
  DetailMoviesViewModel(this._movieService) : super(Initial([])) {
  }

  getMovieById(id) async {
    state = Loading(state.data);
    try {
      var movies = await _movieService.getDetailMovie(id);
      state = Success(movies);
    } catch (exception) {
      state = Error('Something went wrong', state.data);
    }
  }
}
