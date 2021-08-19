import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moviedb/core/common/constants.dart';
import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/models/movie_detail.dart';
import 'package:moviedb/core/providers/dio_provider.dart';
import 'package:moviedb/core/providers/secure_storage.dart';

final movieServiceProvider =
Provider((ref) => MovieService(ref.read(dioProvider), ref.read(storageProvider)));

class MovieService {
  final Dio _dio;
  final FlutterSecureStorage _secureStorage;

  MovieService(this._dio, this._secureStorage);

  Future<List<Movie>> getPopularMovie(int page) async {
    List<Movie> movies = [];
    var response = await _dio.get(
        '${API_URL}discover/movie?api_key=${API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_watch_monetization_types=flatrate');

    if (response.data.length > 0) {
      if (response.data['results'].length > 0) {
        for (var movieRes in response.data['results']) {
          Movie newMovie = new Movie(
            movieRes['id'],
            movieRes['title'],
            double.parse(movieRes['vote_average'].toString()),
            'https://www.themoviedb.org/t/p/w300${movieRes['poster_path']}',
            'https://www.themoviedb.org/t/p/w780${movieRes['backdrop_path']}',
          );
          movies.add(newMovie);
        }
      }
    }

    return movies;
  }

  Future<List<Movie>> getUpcoming(int page, int pageSize) async {
    List<Movie> movies = [];
    var response = await _dio.get(
        '${API_URL}movie/upcoming?api_key=${API_KEY}&language=en-US&page=1');

    if (response.data.length > 0) {
      if (response.data['results'].length > 0) {
        for (var movieRes in response.data['results']) {
          Movie newMovie = new Movie(
              movieRes['id'],
              movieRes['title'],
              double.parse(movieRes['vote_average'].toString()),
              'https://www.themoviedb.org/t/p/w300${movieRes['poster_path']}',
              'https://www.themoviedb.org/t/p/w780${movieRes['backdrop_path']}');
          movies.add(newMovie);
          if (movies.length == pageSize) {
            break;
          }
        }
      }
    }

    return movies;
  }

  Future<List<MovieDetail>> getDetailMovie(int id) async {
    // _secureStorage.write(key: id.toString(), value: "value");
    List<MovieDetail> movies = [];
    List<Genre> genres = [];
    var response = await _dio.get(
        '${API_URL}movie/${id}?api_key=${API_KEY}&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_watch_monetization_types=flatrate');

    print(response.data.length);
    if (response.data.length > 0) {
      if(response.data['genres'].length > 0){
        for (var movieRes in response.data['genres']) {
          Genre newGenre = new Genre(
          movieRes['id'],
          movieRes['name']
          );
          genres.add(newGenre);
        }
      }
      // final cek = await _secureStorage.read(key: response.data['id']);

      MovieDetail newMovie = new MovieDetail(
        response.data['id'],
        response.data['title'],
        double.parse(response.data['vote_average'].toString()),
        double.parse(response.data['popularity'].toString()),
        'https://www.themoviedb.org/t/p/w300${response.data['poster_path']}',
        'https://www.themoviedb.org/t/p/w780${response.data['backdrop_path']}',
        response.data['overview'],
        genres,
        false
        // cek == null ? false : true
      );
      movies.add(newMovie);
    }
    return movies;
  }

  Future<List<MovieCredit>> getCredits(int id) async {
    List<MovieCredit> movies = [];
    var response = await _dio.get(
        '${API_URL}movie/${id}/credits?api_key=${API_KEY}&language=en-US&page=1');

    if (response.data.length > 0) {
      if (response.data['cast'].length > 0) {
        for (var movieRes in response.data['cast']) {
          MovieCredit newMovie = new MovieCredit(
              movieRes['name'],
              'https://www.themoviedb.org/t/p/w300${movieRes['profile_path']}');
          movies.add(newMovie);
        }
      }
    }
    return movies;
  }

  Future<List<MovieVideos>> getVideos(int id) async {
    List<MovieVideos> movies = [];
    var response = await _dio.get(
        '${API_URL}movie/${id}/videos?api_key=${API_KEY}&language=en-US&page=1');

    if (response.data.length > 0) {
      if (response.data['results'].length > 0) {
        for (var movieRes in response.data['results']) {
          MovieVideos newMovie = new MovieVideos(
              movieRes['site'],
              movieRes['key']);
          movies.add(newMovie);
        }
      }
    }
    return movies;
  }

  Future saveFavoriteMovie(MovieDetail movie) async {
    String temp = jsonEncode(movie.toJson());

    _secureStorage.write(key: movie.id.toString(), value: temp);
  }

  Future deleteFavMovie(MovieDetail movie) async {
    final cek = await _secureStorage.read(key: movie.id.toString());
    if(cek != null) {
      _secureStorage.delete(key: movie.id.toString());
    }

  }

  cekMovieisFavorite(MovieDetail movie) async{
    final cek = await _secureStorage.read(key: movie.id.toString());
    print(cek);
    if(cek == null){
      return false;
    }else{
      return true;
    }
  }

  Future<List<MovieDetail>> getMovieList() async{
    List<MovieDetail> lists = [];
    final test = await _secureStorage.readAll();
    test.forEach((key, value) {
      if(value != "value") {
        Map<String, dynamic> userMap = jsonDecode(value);
        MovieDetail user = MovieDetail.fromJson(userMap);
        lists.add(user);
      }
    });
    print("lists");
    print(lists);
    return lists;
  }

  getGenereList(List<Genre> genre) {
    List<String> nama = [];

    genre.forEach((element) {
      nama.add(element.name);
    });

    return nama.join(", ");
  }


}
