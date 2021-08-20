import 'dart:collection';

import 'package:moviedb/core/models/movie.dart';
import 'package:moviedb/core/models/movie_detail.dart';

final List<Genre> genre = [];
final dummyTodo = MovieDetail(1, 'Title', 1, 1, 'Poster', 'backdrop', 'sinopsis', genre, false);
final dummyUpcoming = Movie(550988, "Free Guy", 7.9, "https://www.themoviedb.org/t/p/w300/acCS12FVUQ7blkC8qEbuXbsWEs2.jpg", "https://www.themoviedb.org/t/p/w780/j28p5VwI5ieZnNwfeuZ5Ve3mPsn.jpg");


final dummyList = <MovieDetail>[
  dummyTodo
];

final dummyUpcomingList = <Movie>[
  dummyUpcoming,
  dummyUpcoming,
  dummyUpcoming,
  dummyUpcoming
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