import 'dart:async';

class Movie {
  final String title;
  final double rating;
  final String posterArtUrl;
  final int id;


  const Movie({this.title, this.rating, this.posterArtUrl, this.id});

  Movie.fromJson (Map jsonMap)
    : title = jsonMap['title'],
      rating = jsonMap['vote_average'].toDouble(),
      posterArtUrl = "http://image.tmdb.org/t/p/w500" + jsonMap['backdrop_path'],
      id = jsonMap['id'];
}

abstract class MovieRepo {
  Future<List<Movie>> fetchTopRated();
  Future<Movie> fetchMovieDetails(int movieId);
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}