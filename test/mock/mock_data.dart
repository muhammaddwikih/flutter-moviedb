import 'dart:collection';

import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/models/movie_detail.dart';

final List<Genre> genre = [];
final dummyTodo = MovieDetail(1, 'Title', 1, 1, 'Poster', 'backdrop', 'sinopsis', genre, false);

final dummyList = <MovieDetail>[
  dummyTodo
];

final dummyResponse = LinkedHashSet.from(dummyList);

final dummyResponseApi =
[
  {
    "name": "Todo",
    "detail": "Todo description"
  },
  {
    "name": "Todo",
    "detail": "Todo description"
  },
  {
    "name": "Todo",
    "detail": "Todo description"
  },
  {
    "name": "Todo",
    "detail": "Todo description"
  },
  {
    "name": "Todo",
    "detail": "Todo description"
  },
  {
    "name": "Todo",
    "detail": "Todo description"
  },
  {
    "name": "Todo",
    "detail": "Todo description"
  }
];