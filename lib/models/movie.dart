import 'dart:async';

class Movie {
  final String title;
  final double rating;
  final String posterArtUrl;
  final String backgroundArtUrl;
  final int id;


  const Movie({this.title, this.rating, this.posterArtUrl,this.backgroundArtUrl, this.id});

  Movie.fromJson (Map jsonMap)
    : title = jsonMap['title'],
      rating = jsonMap['vote_average'].toDouble(),
      posterArtUrl = "http://image.tmdb.org/t/p/w342" + jsonMap['poster_path'],
      backgroundArtUrl = "http://image.tmdb.org/t/p/w500" + jsonMap['backdrop_path'], 
      id = jsonMap['id'];
}

abstract class MovieRepo {
  Future<List<Movie>> fetchTopRated();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}