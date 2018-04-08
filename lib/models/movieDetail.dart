import 'dart:async';

class MovieDetail {
  final String title;
  final double rating;
  final String posterArtUrl;
  final backgroundArtUrl;
  final String overview;
  final String tagline;
  final int id;

  const MovieDetail(
      {this.title, this.rating, this.posterArtUrl, this.backgroundArtUrl, this.overview, this.tagline, this.id});

  MovieDetail.fromJson(Map jsonMap)
      : title = jsonMap['title'],
        rating = jsonMap['vote_average'].toDouble(),
        posterArtUrl = "http://image.tmdb.org/t/p/w342" + jsonMap['backdrop_path'],
        backgroundArtUrl = "http://image.tmdb.org/t/p/w500" + jsonMap['poster_path'],
        overview = jsonMap['overview'],
        tagline = jsonMap['tagline'],
        id = jsonMap['id'];
}
abstract class MovieDetailRepo {
  Future<MovieDetail> fetchMovieDetails();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}