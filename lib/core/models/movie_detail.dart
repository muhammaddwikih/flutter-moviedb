import 'dart:convert';

class MovieDetail {
  final int id;
  final String title;
  final double rating;
  final double popularity;
  final String poster;
  final String backdrop;
  final String sinopsis;
  final List<Genre> genre;
  final bool favorite;

  MovieDetail(this.id, this.title, this.rating, this.popularity, this.poster, this.backdrop, this.sinopsis, this.genre, this.favorite);

  MovieDetail.fromJson(Map<String, dynamic> json) :
      id = json['id'],
  title = json['title'],
  rating = json['rating'],
  popularity = json['popularity'],
  poster = json['poster'],
  backdrop = json['backdrop'],
  sinopsis = json['sinopsis'],
  genre = (json['genre'] as List)
      .map((e) => e = Genre.fromJson(e))
      .toList(),
  favorite = false;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'rating': rating,
    'popularity': popularity,
    'poster': poster,
    'backdrop': backdrop,
    'sinopsis': sinopsis,
    'genre': genre,
    'favorite': false
  };
}

class Genre {
  final int id;
  final String name;

  Genre(this.id, this.name);

  Genre.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        name = json['name']
  ;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name
  };
}

class MovieCredit {
  final String nama;
  final String foto;

  MovieCredit(this.nama, this.foto);
}

class MovieVideos {
  final String id;
  final String key;

  MovieVideos(this.id, this.key);
}