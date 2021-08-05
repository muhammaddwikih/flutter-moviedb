class MovieDetail {
  final int id;
  final String title;
  final double rating;
  final double popularity;
  final String poster;
  final String backdrop;
  final String sinopsis;
  final List<Genre> genre;

  MovieDetail(this.id, this.title, this.rating, this.popularity, this.poster, this.backdrop, this.sinopsis, this.genre);
}

class Genre {
  final int id;
  final String name;

  Genre(this.id, this.name);
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