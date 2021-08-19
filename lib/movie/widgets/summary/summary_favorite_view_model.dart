
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/core/models/async_state.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/services/movie_service.dart';

final summaryFavoriteViewModelProvider =
StateNotifierProvider<SummaryFavoriteViewModel, bool>(
        (ref) => SummaryFavoriteViewModel(ref.read(movieServiceProvider)));

class SummaryFavoriteViewModel extends StateNotifier<bool> {
  final MovieService _movieService;

  SummaryFavoriteViewModel(this._movieService) : super(false);

  void favorite(id) {
    var cek = _movieService.cekMovieisFavorite(id);
    if (state == true) {
      deleteFavMovie(id);
      state = false;
    } else {
      saveFavMovie(id);
      state = true;
    }
  }

  saveFavMovie(id) async {
    try {
      // print("masuk fav");
      _movieService.saveFavoriteMovie(id);
    } catch (exception) {
      print("error coy");
      print(exception.toString());
      // state = false;
    }
  }

  deleteFavMovie(id) async {
    try {
      var movies = await _movieService.deleteFavMovie(id);
    } catch (exception) {
      // state = false;
    }
  }

  checkFav(id) async {
    try {
      var cek = await _movieService.cekMovieisFavorite(id);
      print(cek);
      state = cek;
    } catch (exception) {
      print("error coy");
      print(exception.toString());
      // state = false;
    }
  }

}