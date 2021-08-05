import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/services/movie_service.dart';

final trailerMoviesViewModelProvider =
StateNotifierProvider<TrailerMoviesViewModel, AsyncState<List<MovieVideos>>>(
        (ref) => TrailerMoviesViewModel(ref.read(movieServiceProvider)));

class TrailerMoviesViewModel extends StateNotifier<AsyncState<List<MovieVideos>>> {
  final MovieService _movieService;
  TrailerMoviesViewModel(this._movieService) : super(Initial([])) {
  }

  getMovieById(id) async {
    state = Loading(state.data);
    try {
      var movies = await _movieService.getVideos(id);
      state = Success(movies);
    } catch (exception) {
      state = Error('Something went wrong', state.data);
    }
  }
}
