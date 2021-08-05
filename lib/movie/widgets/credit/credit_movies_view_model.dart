import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/services/movie_service.dart';

final creditMoviesViewModelProvider =
StateNotifierProvider<CreditMoviesViewModel, AsyncState<List<MovieCredit>>>(
        (ref) => CreditMoviesViewModel(ref.read(movieServiceProvider)));

class CreditMoviesViewModel extends StateNotifier<AsyncState<List<MovieCredit>>> {
  final MovieService _movieService;
  CreditMoviesViewModel(this._movieService) : super(Initial([])) {}

  getMovieById(id) async {
    state = Loading(state.data);
    try {
      var movies = await _movieService.getCredits(id);
      state = Success(movies);
    } catch (exception) {
      state = Error('Something went wrong', state.data);
    }
  }
}
