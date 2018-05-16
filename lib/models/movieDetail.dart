import 'dart:async';

class MovieDetail {
  final String title;
  final double rating;
  final String posterArtUrl;
  final backgroundArtUrl;
  final List<Genre> genres;
  final String overview;
  final String tagline;
  final int id;

  const MovieDetail(
      {this.title, this.rating, this.posterArtUrl, this.backgroundArtUrl, this.genres, this.overview, this.tagline, this.id});

  MovieDetail.fromJson(Map jsonMap)
      : title = jsonMap['title'],
        rating = jsonMap['vote_average'].toDouble(),
        posterArtUrl = "http://image.tmdb.org/t/p/w342" + jsonMap['backdrop_path'],
        backgroundArtUrl = "http://image.tmdb.org/t/p/w500" + jsonMap['poster_path'],
        genres = (jsonMap['genres'] as List).map((i) => Genre.fromJson(i)).toList(),
        overview = jsonMap['overview'],
        tagline = jsonMap['tagline'],
        id = jsonMap['id'];
}
class Genre {
  final int id;
  final String genre;

  const Genre(this.id, this.genre);

  Genre.fromJson(Map jsonMap)
    : id = jsonMap['id'],
      genre = jsonMap['name'];
}
abstract class MovieDetailsRepo {
  Future<MovieDetail> fetchMovieDetails(int movieId);
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}